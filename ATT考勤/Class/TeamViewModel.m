//
//  TeamViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamViewModel.h"
#import "TeamModel.h"
#import "TeamListModel.h"

@implementation TeamViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
    
        
        [self.tableViewSubject sendNext:nil];
        
        DismissHud();
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

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body1 =[NSString stringWithFormat: @"<findAllDeptByCompanyCode xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 </findAllDeptByCompanyCode>",self.companyCode];
                
                [self SOAPData:findAllDeptByCompanyCode soapBody:body1 success:^(NSString *result1) {
                    NSString *xmlDoc1 = [self getFilterStr:result1 filter1:@"<ns2:findAllDeptByCompanyCodeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllDeptByCompanyCodeResponse>"];
                    
                    
                    NSMutableArray *arrTmp = [LSCoreToolCenter xmlToArray:xmlDoc1 class:[TeamModel class] rowRootName:@"Depts"];
                    NSMutableArray *arr = [NSMutableArray array];
                    
                    for(int i = 0;i<arrTmp.count;i++){
                        TeamModel *team = arrTmp[i];
                        NSString *body2 =[NSString stringWithFormat: @"<findAllEmpByCompanyDeptCode xmlns=\"http://service.webservice.vada.com/\">\
                                         <companyCode xmlns=\"\">%@</companyCode>\
                                         <deptCode xmlns=\"\">%@</deptCode>\
                                         </findAllEmpByCompanyDeptCode>",team.companyCode,team.deptCode];
                        
                        [self SOAPData:findAllEmpByCompanyDeptCode soapBody:body2 success:^(NSString *result2) {
                            NSString *xmlDoc2 = [self getFilterStr:result2 filter1:@"<ns2:findAllEmpByCompanyDeptCodeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllEmpByCompanyDeptCodeResponse>"];
                            
                            
                            NSMutableArray *arrT = [LSCoreToolCenter xmlToArray:xmlDoc2 class:[TeamListModel class] rowRootName:@"Emps"];
                            team.deptCount =[NSString stringWithFormat:@"%lu",(unsigned long)arrT.count] ;
                            [arr addObject:team];
                            if (i==arrTmp.count-1) {
                                self.arr = arr;
                                [subscriber sendNext:nil];
                                [subscriber sendCompleted];
                            }
                            
                        } failure:^(NSError *error) {
                            DismissHud();
                            ShowErrorStatus(@"请检查网络状态");
                        }];
 
                    }
            
                } failure:^(NSError *error) {
                    DismissHud();
                    ShowErrorStatus(@"请检查网络状态");
                }];
                
                return nil;
            }];
        }];
    }
    
    return _refreshDataCommand;
}

-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject];
    }
    return _tableViewSubject;
    
}

@end
