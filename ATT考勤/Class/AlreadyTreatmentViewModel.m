//
//  AlreadyTreatmentViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AlreadyTreatmentViewModel.h"
#import "AlreadyTreatmentModel.h"
@implementation AlreadyTreatmentViewModel
#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<200) {
            ShowMessage(@"没有更多数据");
        }else{
            NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findApplyAlreadyProcResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findApplyAlreadyProcResponse>"];
            
            NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc class:[AlreadyTreatmentModel class] rowRootName:@"FlowCheckModels"];
            
            NSMutableArray *arr = [NSMutableArray array];
            NSInteger count = arrTmp.count;
            for(int i = 0;i<count;i++){
                AlreadyTreatmentModel *already = arrTmp[i];
                already.empColor = randomColorA;
                [arr addObject:already];
            }
            self.arr = arr;
            [self.tableViewSubject sendNext:nil];
        }
        
        
        
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findApplyAlreadyProc xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findApplyAlreadyProc>",self.companyCode,self.userCode];
                
                [self SOAPData:findApplyAlreadyProc soapBody:body success:^(NSString *result) {
                    
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

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject] ;
    }
    return _tableViewSubject;
}


-(RACSubject *)cellclickSubject{
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}
@end
