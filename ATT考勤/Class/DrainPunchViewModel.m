//
//  DrainPunchViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DrainPunchViewModel.h"
#import "DrainPunchModel.h"

@implementation DrainPunchViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
         DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAttendPaintLeaveTypeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAttendPaintLeaveTypeResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[DrainPunchModel class] rowRootName:@"AttendPaidLeaveWorks"];
        self.arr = arr;
        
        [self.tableViewSubject sendNext:xmlDoc];
        
       
    }];
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    [self.applyForgetCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {

        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
        if ([xmlDoc isEqualToString:@"0"]) {
            ShowMessage(@"漏打卡申请成功");
        }else{
            ShowMessage(@"漏打卡申请失败");
        }
        [self.submitclickSubject sendNext:nil];
        
    }];
    
    
    [[[self.applyForgetCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
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

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}


- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findAttendPaintLeaveType xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 </findAttendPaintLeaveType>",self.companyCode];
                
                [self SOAPData:findAttendPaintLeaveType soapBody:body success:^(NSString *result) {
                    
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


- (RACCommand *)applyForgetCommand {
    
    if (!_applyForgetCommand) {
        
        @weakify(self);
        _applyForgetCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<saveApplyForget xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <forgetDatetime xmlns=\"\">%@</forgetDatetime>\
                                 <reailForgetDatetime xmlns=\"\">%@</reailForgetDatetime>\
                                 <applyStatus xmlns=\"\">%@</applyStatus>\
                                 <applyReason xmlns=\"\">%@</applyReason>\
                                 <flowInstanceId xmlns=\"\">%@</flowInstanceId>\
                                 <copyUserCode xmlns=\"\">%@</copyUserCode>\
                                 <copyUserName xmlns=\"\">%@</copyUserName>\
                                 <applyUserCode xmlns=\"\">%@</applyUserCode>\
                                 <applyUserName xmlns=\"\">%@</applyUserName>\
                                 </saveApplyForget>",self.companyCode,self.applyStartDatetime,self.applyEndDatetime,self.applyStatus,self.applyReason,self.flowInstanceId,self.cuserCode,self.cuserName,self.applyUserCode,self.applyUserName];
               
                [self SOAPData:saveApplyForget soapBody:body success:^(NSString *result) {
                    
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
    return _applyForgetCommand;
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
