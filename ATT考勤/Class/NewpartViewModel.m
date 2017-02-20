//
//  NewpartViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "NewpartViewModel.h"

@implementation NewpartViewModel

#pragma mark private
-(void)h_initialize{
    
    
    [self.sendclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        NSString *xmlDoc = [self getFilterStr:result filter:@"String"];
        NSLog(@"%@",xmlDoc);
        DismissHud();
        [self.SMSbackSubject sendNext:xmlDoc];
        
    }];
    
    
    [[[self.sendclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}


-(RACSubject *)createclickSubject{
    if (!_createclickSubject) {
        _createclickSubject = [RACSubject subject];
    }
    return _createclickSubject;
}


-(RACSubject *)SMSbackSubject{
    if (!_SMSbackSubject) {
        _SMSbackSubject = [RACSubject subject];
    }
    return _SMSbackSubject;
    
}

#pragma mark lazyload
-(RACCommand *)sendclickCommand{
    if (!_sendclickCommand) {
        
        _sendclickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<sendValidateSMS xmlns=\"http://service.webservice.vada.com/\">\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 </sendValidateSMS>",self.user];
                
                [self SOAPData:sendValidateSMS soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    ShowErrorStatus(@"请检查网络状态");
                    DismissHud();
                }];
                return nil;
            }];
        }];
        
    }
    return _sendclickCommand;
}

@end
