//
//  ForgetPwdViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ForgetPwdViewModel.h"

@implementation ForgetPwdViewModel

#pragma mark private
-(void)h_initialize{
    
    
    [self.sendclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
         NSLog(@"%@",result);
//        NSLog(@"666");
        NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];

        if ([xmlDoc isEqualToString:@"0"]) {
            [self.finishclickSubject sendNext:nil];
        }else{
            
        }
        
        DismissHud();
    }];
    
    
    [[[self.sendclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}

-(RACSubject *)finishclickSubject{
    if (!_finishclickSubject) {
        _finishclickSubject = [RACSubject subject];
    }
    return _finishclickSubject;
    
}

#pragma mark lazyload
-(RACCommand *)sendclickCommand{
    if (!_sendclickCommand) {
        
        _sendclickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<modifyUserPwd xmlns=\"http://service.webservice.vada.com/\">\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 <newPassword xmlns=\"\">%@</newPassword>\
                                 </modifyUserPwd>",self.telphone,self.pwd];
                NSLog(@"1");
                [self SOAPData:modifyUserPwd soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    [self toast:@"请检查网络状态"];
                    DismissHud();
                }];
                return nil;
            }];
        }];
        
    }
    return _sendclickCommand;
}

@end
