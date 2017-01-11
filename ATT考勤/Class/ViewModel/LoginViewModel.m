//
//  LoginViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/22.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

#pragma mark private
-(void)h_initialize{
    
    @weakify(self);
    [self.loginclickCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        
        @strongify(self);
        if ([self.user isEqualToString:@"123"]&&[self.pwd isEqualToString:@"123"]) {
            [self.loginclickSubject sendNext:@(HSuccess)];
        }else{
            [self.loginclickSubject sendNext:@(HFailure)];
        }
        DismissHud();
    }];
    
    
    [[[self.loginclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            
            ShowMaskStatus(@"正在加载");
        }
    }];
    
}

#pragma mark lazyload
-(RACCommand *)loginclickCommand{
    if (!_loginclickCommand) {
        
        @weakify(self);
        _loginclickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSLog(@"%@  %@",self.user,self.pwd);
                
                [self.request POST:REQUEST_URL parameters:nil success:^(CMRequest *request, NSString *responseString) {
                    
                    NSLog(@"成功");
                    [subscriber sendNext:responseString];
                    [subscriber sendCompleted];
                    
                } failure:^(CMRequest *request, NSError *error) {
                    
                    ShowErrorStatus(@"网络连接失败");
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
        
        
        
    }
    return _loginclickCommand;
    
}

-(RACSubject *)loginclickSubject{
    if (!_loginclickSubject) {
        _loginclickSubject = [RACSubject subject];
    }
    return _loginclickSubject;
}

-(RACSubject *)forgetclickSubject{
    if (!_forgetclickSubject) {
        _forgetclickSubject = [RACSubject subject];
    }
    return _forgetclickSubject;
}

-(RACSubject *)newpartclickSubject{
    if (!_newpartclickSubject) {
        _newpartclickSubject = [RACSubject subject];
    }
    return _newpartclickSubject;
}

-(RACSubject *)weixinclickSubject{
    if (!_weixinclickSubject) {
        _weixinclickSubject = [RACSubject subject];
    }
    return _weixinclickSubject;
}

-(RACSubject *)qqclickSubject{
    if (!_qqclickSubject) {
        _qqclickSubject = [RACSubject subject];
    }
    return _qqclickSubject;
}


-(RACSubject *)sinaclickSubject{
    if (!_sinaclickSubject) {
        _sinaclickSubject = [RACSubject subject];
    }
    return _sinaclickSubject;
}

@end
