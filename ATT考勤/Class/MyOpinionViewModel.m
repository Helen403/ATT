//
//  MyOpinionViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyOpinionViewModel.h"

@implementation MyOpinionViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.suggbackCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        
//        [self.tableViewSubject sendNext:nil];
        
    }];
    
    
    [[[self.suggbackCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
  
}

- (RACCommand *)suggbackCommand {
    
    if (!_suggbackCommand) {
        
        @weakify(self);
        _suggbackCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
//                NSString *body =[NSString stringWithFormat: @"<saveApplyOverTime xmlns=\"http://service.webservice.vada.com/\">\
//                                 <companyCode xmlns=\"\">%@</companyCode>\
//                                 <applyStartDatetime xmlns=\"\">%@</applyStartDatetime>\
//                                 <applyEndDatetime xmlns=\"\">%@</applyEndDatetime>\
//                                 <applyLenHours xmlns=\"\">%@</applyLenHours>\
//                                 <applyReason xmlns=\"\">%@</applyReason>\
//                                 <applyStatus xmlns=\"\">%@</applyStatus>\
//                                 <flowInstanceId xmlns=\"\">%@</flowInstanceId>\
//                                 <overType xmlns=\"\">%@</overType>\
//                                 <resultType xmlns=\"\">%@</resultType>\
//                                 <applyUserCode xmlns=\"\">%@</applyUserCode>\
//                                 <applyUserName xmlns=\"\">%@</applyUserName>\
//                                 </saveApplyOverTime>",self.companyCode,self.applyStartDatetime,self.applyEndDatetime,self.applyLenHours,self.applyReason,self.applyStatus,self.flowInstanceId,self.overType,self.resultType,self.applyUserCode,self.applyUserName];
//                
//                [self SOAPData:saveApplyOverTime soapBody:body success:^(NSString *result) {
//                    
//                    [subscriber sendNext:result];
//                    [subscriber sendCompleted];
//                } failure:^(NSError *error) {
//                    DismissHud();
//                    ShowErrorStatus(@"请检查网络状态");
//                }];
                
                return nil;
            }];
        }];
    }
    return _suggbackCommand;
}


@end
