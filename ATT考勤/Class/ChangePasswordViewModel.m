//
//  ChangeViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/2/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChangePasswordViewModel.h"

@implementation ChangePasswordViewModel
#pragma mark private
-(void)h_initialize{
    
    [self.sendclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        NSString *xmlDoc = [self getFilterStr:result filter:@"String"];
        if ([xmlDoc isEqualToString:@"0"]) {
            ShowMessage(@"修改成功");
            [self.successSubject sendNext:nil];
        }else{
            ShowErrorStatus(@"修改失败");
            [self.failSubject sendNext:nil];
        }

    }];
    
    
    [[[self.sendclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
}

#pragma mark lazyload
-(RACCommand *)sendclickCommand{
    if (!_sendclickCommand) {
        
        _sendclickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<modifyUserPwd xmlns=\"http://service.webservice.vada.com/\">\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 <newPassword xmlns=\"\">%@</newPassword>\
                                 </modifyUserPwd>",self.telphone,self.newpassword];
                
                [self SOAPData:modifyUserPwd soapBody:body success:^(NSString *result) {

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
    return _sendclickCommand;
}


-(RACSubject *)successSubject{
    if (!_successSubject) {
        _successSubject = [RACSubject subject] ;
    }
    return _successSubject;
}

-(RACSubject *)failSubject{
    if (!_failSubject) {
        _failSubject = [RACSubject subject] ;
    }
    return _failSubject;
}

@end
