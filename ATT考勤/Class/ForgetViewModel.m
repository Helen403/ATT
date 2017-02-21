//
//  ForgetViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ForgetViewModel.h"
#import "UserModel.h"

@implementation ForgetViewModel

#pragma mark private
-(void)h_initialize{
    
    
    [self.sendclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
          DismissHud();
        if(result.length<200){
            ShowErrorStatus(@"该手机号没注册");
            [self.telphoneBackFailSubject sendNext:nil];
        }else{
            
            NSString *xmlDoc = [self getFilterStr:result filter:@"String"];
            NSLog(@"%@",xmlDoc);
            [self.SMSbackSubject sendNext:xmlDoc];
        }
    }];
    
    
    [[[self.sendclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}

-(RACSubject *)forgetPwdclickSubject{
    if (!_forgetPwdclickSubject) {
        _forgetPwdclickSubject = [RACSubject subject];
    }
    return _forgetPwdclickSubject;
}


-(RACSubject *)telphoneBackFailSubject{
    if (!_telphoneBackFailSubject) {
        _telphoneBackFailSubject = [RACSubject subject];
    }
    return _telphoneBackFailSubject;
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
                NSString *body =[NSString stringWithFormat: @"<findUserByTelphone xmlns=\"http://service.webservice.vada.com/\">\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 </findUserByTelphone>",self.user];
                
                [self SOAPData:findUserByTelphone soapBody:body success:^(NSString *result) {
                    
                    if (result.length <200) {
                        
                        [subscriber sendNext:result];
                        [subscriber sendCompleted];
                    }else{
                        
                        NSString *body =[NSString stringWithFormat: @"<sendValidateSMS xmlns=\"http://service.webservice.vada.com/\">\
                                         <telphone xmlns=\"\">%@</telphone>\
                                         </sendValidateSMS>",self.user];
                        
                        [self SOAPData:sendValidateSMS soapBody:body success:^(NSString *result) {
                            
                            [subscriber sendNext:result];
                            [subscriber sendCompleted];
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
    return _sendclickCommand;
}

@end
