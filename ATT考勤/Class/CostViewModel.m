//
//  CostViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CostViewModel.h"
#import "CostWorkModel.h"
#import "CostModel.h"

@implementation CostViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAttendCostTypeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAttendCostTypeResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[CostWorkModel class] rowRootName:@"AttendCostWorks"];
        
        self.arrCostType = arr;
        [self.tableViewSubject sendNext:nil];
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    [self.applyCostCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
        if ([xmlDoc isEqualToString:@"0"]) {
            ShowMessage(@"费用申请发送成功");
        }else{
            ShowMessage(@"费用申请发送失败");
        }
        [self.submitclickSubject sendNext:nil];
        
    }];
    
    
    [[[self.applyCostCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    [self.flowTemplateCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
        if ([xmlDoc isEqualToString:@"-1"]) {
            ShowMessage(@"审批人没设置");
        }else{
            [self.flowTemplateSubject sendNext:xmlDoc];
        }
        
        
    }];
    
    
    [[[self.flowTemplateCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}



-(RACSubject *)flowTemplateSubject{
    if (!_flowTemplateSubject) {
        _flowTemplateSubject = [RACSubject subject];
    }
    return _flowTemplateSubject;
}

-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject];
    }
    return _tableViewSubject;
}

-(RACSubject *)submitclickSubject{
    if (!_submitclickSubject) {
        _submitclickSubject = [RACSubject subject];
    }
    return _submitclickSubject;
}

-(NSMutableArray *)arrDept{
    if (!_arrDept) {
        _arrDept = [NSMutableArray array];
    }
    return _arrDept;
}


-(NSMutableArray *)arrCostType{
    if (!_arrCostType) {
        _arrCostType = [NSMutableArray array];
    }
    return _arrCostType;
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
                
                [self SOAPData:findAllDeptByCompanyCode soapBody:body1 success:^(NSString *result) {
                    NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAllDeptByCompanyCodeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllDeptByCompanyCodeResponse>"];
                    
                    NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[CostModel class] rowRootName:@"Depts"];
                    self.arrDept = arr;
                    
                    
                    NSString *body2 =[NSString stringWithFormat: @"<findAttendCostType xmlns=\"http://service.webservice.vada.com/\">\
                                      <companyCode xmlns=\"\">%@</companyCode>\
                                      </findAttendCostType>",self.companyCode];
                    
                    [self SOAPData:findAttendCostType soapBody:body2 success:^(NSString *result) {
                        
                        [subscriber sendNext:result];
                        [subscriber sendCompleted];
                    } failure:^(NSError *error) {
                        DismissHud();
                        ShowErrorStatus(@"请检查网络状态");
                        [subscriber sendNext:@"netFail"];
                        [subscriber sendCompleted];
                        
                    }];
                    
                    
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


- (RACCommand *)applyCostCommand {
    
    if (!_applyCostCommand) {
        
        @weakify(self);
        _applyCostCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<saveApplyCost xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <applyStartDatetime xmlns=\"\">%@</applyStartDatetime>\
                                 <applyDeptCode xmlns=\"\">%@</applyDeptCode>\
                                 <applyDeptName xmlns=\"\">%@</applyDeptName>\
                                 <applyReason xmlns=\"\">%@</applyReason>\
                                 <applyStatus xmlns=\"\">%@</applyStatus>\
                                 <flowInstanceId xmlns=\"\">%@</flowInstanceId>\
                                 <copyUserCode xmlns=\"\">%@</copyUserCode>\
                                 <copyUserName xmlns=\"\">%@</copyUserName>\
                                 <workLsh xmlns=\"\">%@</workLsh>\
                                 <workName xmlns=\"\">%@</workName>\
                                  <applyMoney xmlns=\"\">%@</applyMoney>\
                                 <applyUserCode xmlns=\"\">%@</applyUserCode>\
                                 <applyUserName xmlns=\"\">%@</applyUserName>\
                                 </saveApplyCost>",self.companyCode,self.applyStartDatetime,self.applyDeptCode,self.applyDeptName,self.applyReason,self.applyStatus,self.flowInstanceId,self.cuserCode,self.cuserName,self.workLsh,self.workName,self.applyMoney,self.applyUserCode,self.applyUserName];
  
                [self SOAPData:saveApplyCost soapBody:body success:^(NSString *result) {
                    
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
    return _applyCostCommand;
}


- (RACCommand *)flowTemplateCommand {
    
    if (!_flowTemplateCommand) {
        
        @weakify(self);
        _flowTemplateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<saveFlowTemplate xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <flowTypeName xmlns=\"\">%@</flowTypeName>\
                                 <stepUserCodes xmlns=\"\">%@</stepUserCodes>\
                                 <stepUserNames xmlns=\"\">%@</stepUserNames>\
                                 </saveFlowTemplate>",self.companyCode,self.flowTypeName,self.stepUserCodes,self.stepUserNames];
                
                [self SOAPData:saveFlowTemplate soapBody:body success:^(NSString *result) {
                    
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
    return _flowTemplateCommand;
}

@end
