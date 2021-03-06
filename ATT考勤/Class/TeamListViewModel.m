//
//  TeamListViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamListViewModel.h"
#import "TeamListModel.h"


@implementation TeamListViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
         DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAllEmpByCompanyDeptCodeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllEmpByCompanyDeptCodeResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[TeamListModel class] rowRootName:@"Emps"];
        self.arr = arr;
        
        [self.tableViewSubject sendNext:xmlDoc];
        
       
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}


-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

-(RACSubject *)cellclickSubject{
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}



-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject];
    }
    return _tableViewSubject;
    
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findAllEmpByCompanyDeptCode xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                    <deptCode xmlns=\"\">%@</deptCode>\
                                 </findAllEmpByCompanyDeptCode>",self.companyCode,self.deptCode];

                [self SOAPData:findAllEmpByCompanyDeptCode soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    DismissHud();
                    ShowErrorStatus(@"请检查网络状态");
                    [subscriber sendNext:@"netFail"];
                    [subscriber sendCompleted];
                    
                }];
                
                return nil;
            }];
        }];
    }
    return _refreshDataCommand;
}



@end
