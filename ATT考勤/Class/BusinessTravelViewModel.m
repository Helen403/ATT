//
//  BusinessTravelViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "BusinessTravelViewModel.h"
#import "BusinessTravelModel.h"

@implementation BusinessTravelViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAttendOutWorkResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAttendOutWorkResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[BusinessTravelModel class] rowRootName:@"AttendOutWorks"];
        self.arr = arr;
        
        [self.tableViewSubject sendNext:xmlDoc];
        
        DismissHud();
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    [self.applyOutWorkCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        
        DismissHud();
        
        NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
        if ([xmlDoc isEqualToString:@"0"]) {
            ShowMessage(@"出差申请成功");
        }else{
            ShowMessage(@"出差申请失败");
        }
        [self.submitclickSubject sendNext:nil];
        
    }];
    
    
    [[[self.applyOutWorkCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
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
                
                NSString *body =[NSString stringWithFormat: @"<findAttendOutWork xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 </findAttendOutWork>",self.companyCode];
                
                [self SOAPData:findAttendOffWorkType soapBody:body success:^(NSString *result) {
                    
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


- (RACCommand *)applyOutWorkCommand {
    
    if (!_applyOutWorkCommand) {
        
        @weakify(self);
        _applyOutWorkCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<saveApplyOutWork xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <applyStartDatetime xmlns=\"\">%@</applyStartDatetime>\
                                 <applyEndDatetime xmlns=\"\">%@</applyEndDatetime>\
                                 <applyLenHours xmlns=\"\">%@</applyLenHours>\
                                 <applyReason xmlns=\"\">%@</applyReason>\
                                 <applyStatus xmlns=\"\">%@</applyStatus>\
                                 <flowInstanceId xmlns=\"\">%@</flowInstanceId>\
                                 <outAddress xmlns=\"\">%@</outAddress>\
                                 <outFinaceType xmlns=\"\">%@</outFinaceType>\
                                 <applyUserCode xmlns=\"\">%@</applyUserCode>\
                                 <applyUserName xmlns=\"\">%@</applyUserName>\
                                 </saveApplyOutWork>",self.companyCode,self.applyStartDatetime,self.applyEndDatetime,self.applyLenHours,self.applyReason,self.applyStatus,self.flowInstanceId,self.outAddress,self.outFinaceType,self.applyUserCode,self.applyUserName];
                
                [self SOAPData:saveApplyOutWork soapBody:body success:^(NSString *result) {
                    
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
    return _applyOutWorkCommand;
}


@end
