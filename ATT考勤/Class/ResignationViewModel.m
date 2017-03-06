//
//  ResignationViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ResignationViewModel.h"
#import "ResignationModel.h"

@implementation ResignationViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAttendLeaveTypeResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAttendLeaveTypeResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[ResignationModel class] rowRootName:@"AttendLeaveWorks"];
        self.arr = arr;
        
        [self.tableViewSubject sendNext:xmlDoc];
        
        DismissHud();
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    [self.applyLeaveCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        
        DismissHud();
        
        NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
        if ([xmlDoc isEqualToString:@"0"]) {
            ShowMessage(@"调班申请成功");
        }else{
            ShowMessage(@"调班申请失败");
        }
        [self.submitclickSubject sendNext:nil];
        
    }];
    
    
    [[[self.applyLeaveCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
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
                
                NSString *body =[NSString stringWithFormat: @"<findAttendLeaveType xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 </findAttendLeaveType>",self.companyCode];
                
                [self SOAPData:findAttendLeaveType soapBody:body success:^(NSString *result) {
                    
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
    return _refreshDataCommand;
}


- (RACCommand *)applyLeaveCommand {
    
    if (!_applyLeaveCommand) {
        
        @weakify(self);
        _applyLeaveCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<saveApplyLeave xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <applyStartDatetime xmlns=\"\">%@</applyStartDatetime>\
                                 <applyEndDatetime xmlns=\"\">%@</applyEndDatetime>\
                                 <applyReason xmlns=\"\">%@</applyReason>\
                                 <applyStatus xmlns=\"\">%@</applyStatus>\
                                 <flowInstanceId xmlns=\"\">%@</flowInstanceId>\
                                 <copyUserCode xmlns=\"\">%@</copyUserCode>\
                                 <copyUserName xmlns=\"\">%@</copyUserName>\
                                 <workLsh xmlns=\"\">%@</workLsh>\
                                 <workName xmlns=\"\">%@</workName>\
                                 <applyUserCode xmlns=\"\">%@</applyUserCode>\
                                 <applyUserName xmlns=\"\">%@</applyUserName>\
                                 </saveApplyLeave>",self.companyCode,self.applyStartDatetime,self.applyEndDatetime,self.applyReason,self.applyStatus,self.flowInstanceId,self.cuserCode,self.cuserName,self.workLsh,self.workName,self.applyUserCode,self.applyUserName];
               // NSLog(@"%@",body);
                [self SOAPData:saveApplyLeave soapBody:body success:^(NSString *result) {
                    
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
    return _applyLeaveCommand;
}
@end
