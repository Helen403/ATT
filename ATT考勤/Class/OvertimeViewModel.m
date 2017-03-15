//
//  OvertimeViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "OvertimeViewModel.h"
#import "OvertimeModel.h"

@implementation OvertimeViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAttendOverTimeWorkTypeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAttendOverTimeWorkTypeResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[OvertimeModel class] rowRootName:@"AttendOverTimeWorks"];
        self.arrOverTimeWorkType = arr;
        [self.tableViewSubject sendNext:nil];
        DismissHud();
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    [self.applyOverTimeCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        DismissHud();
        
        NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
        if ([xmlDoc isEqualToString:@"0"]) {
            ShowMessage(@"加班申请成功");
        }else{
            ShowMessage(@"加班申请失败");
        }
        [self.submitclickSubject sendNext:nil];
        
    }];
    
    
    [[[self.applyOverTimeCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    [self.flowTemplateCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        DismissHud();
        
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

-(NSMutableArray *)arrOverTimeTypeWork{
    if (!_arrOverTimeTypeWork) {
        _arrOverTimeTypeWork = [NSMutableArray array];
    }
    return _arrOverTimeTypeWork;
}


-(NSMutableArray *)arrOverTimeWorkType{
    if (!_arrOverTimeWorkType) {
        _arrOverTimeWorkType = [NSMutableArray array];
    }
    return _arrOverTimeWorkType;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                NSString *body1 =[NSString stringWithFormat: @"<findAttendOverTimeTypeWork xmlns=\"http://service.webservice.vada.com/\">\
                                  <companyCode xmlns=\"\">%@</companyCode>\
                                  </findAttendOverTimeTypeWork>",self.companyCode];
                
                [self SOAPData:findAttendOverTimeTypeWork soapBody:body1 success:^(NSString *result) {
                    NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAttendOverTimeTypeWorkResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAttendOverTimeTypeWorkResponse>"];
                    
                    NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[OvertimeModel class] rowRootName:@"AttendOverTimeTypeWorks"];
                    self.arrOverTimeTypeWork = arr;
                    
                    NSString *body2 =[NSString stringWithFormat: @"<findAttendOverTimeWorkType xmlns=\"http://service.webservice.vada.com/\">\
                                      <companyCode xmlns=\"\">%@</companyCode>\
                                      </findAttendOverTimeWorkType>",self.companyCode];
                    
                    [self SOAPData:findAttendOverTimeWorkType soapBody:body2 success:^(NSString *result) {
                        
                        [subscriber sendNext:result];
                        [subscriber sendCompleted];
                    } failure:^(NSError *error) {
                        DismissHud();
                        ShowErrorStatus(@"请检查网络状态");
                        
                    }];
                    
                    
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


- (RACCommand *)applyOverTimeCommand {
    
    if (!_applyOverTimeCommand) {
        
        @weakify(self);
        _applyOverTimeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<saveApplyOverTime xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <applyStartDatetime xmlns=\"\">%@</applyStartDatetime>\
                                 <applyEndDatetime xmlns=\"\">%@</applyEndDatetime>\
                                 <applyLenHours xmlns=\"\">%@</applyLenHours>\
                                 <applyReason xmlns=\"\">%@</applyReason>\
                                 <applyStatus xmlns=\"\">%@</applyStatus>\
                                 <flowInstanceId xmlns=\"\">%@</flowInstanceId>\
                                 <overType xmlns=\"\">%@</overType>\
                                 <resultType xmlns=\"\">%@</resultType>\
                                 <applyUserCode xmlns=\"\">%@</applyUserCode>\
                                 <applyUserName xmlns=\"\">%@</applyUserName>\
                                 </saveApplyOverTime>",self.companyCode,self.applyStartDatetime,self.applyEndDatetime,self.applyLenHours,self.applyReason,self.applyStatus,self.flowInstanceId,self.overType,self.resultType,self.applyUserCode,self.applyUserName];
                
                [self SOAPData:saveApplyOverTime soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    DismissHud();
                    ShowErrorStatus(@"请检查网络状态");
                }];
                
                return nil;
            }];
        }];
    }
    return _applyOverTimeCommand;
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
                }];
                
                return nil;
            }];
        }];
    }
    return _flowTemplateCommand;
}


@end
