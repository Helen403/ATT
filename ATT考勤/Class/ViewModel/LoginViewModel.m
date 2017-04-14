//
//  LoginViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/22.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "LoginViewModel.h"
#import "GDataXMLNode.h"

#import "UserModel.h"

@implementation LoginViewModel

#pragma mark private
-(void)h_initialize{
    
    @weakify(self);
    [self.loginclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            [self.netFailSubject sendNext:nil];
            
        }else{
        
        if (result.length<200) {
          
            [self.loginNumclickFail sendNext:nil];
        }else{
            
            NSDictionary *xmlDoc = [self getFilter:result filter:@"User"];
            
            UserModel *model = [UserModel mj_objectWithKeyValues:xmlDoc];
            NSString *password = [self.pwd md5String];
            
            @strongify(self);
            if ([self.telphone isEqualToString:model.userTelphone]&&[password isEqualToString:model.userPassword]) {
                //存储对象
                saveModel(model, @"user");
                [[NSUserDefaults standardUserDefaults] setObject:model.userCode forKey:@"userCode"];
                [[NSUserDefaults standardUserDefaults] setObject:xmlDoc forKey:@"returnCode"];
                
                [[NSUserDefaults standardUserDefaults] setObject:model.userRealName forKey:@"userRealName"];
                
                
                [[NSUserDefaults standardUserDefaults] setObject:model.userCode forKey:@"createUserCode"];
                [[NSUserDefaults standardUserDefaults] setObject:self.telphone forKey:@"myUser"];
                
                [self.loginclickSubject sendNext:nil];
            }else{
                [self.loginclickFail sendNext:nil];
            }
            
        }
        }
    }];
    
    
    [[[self.loginclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}

#pragma mark lazyload
-(RACCommand *)loginclickCommand{
    if (!_loginclickCommand) {
        
        _loginclickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<findUserByTelphone xmlns=\"http://service.webservice.vada.com/\">\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 </findUserByTelphone>",self.telphone];
                
                [self SOAPData:findUserByTelphone soapBody:body success:^(NSString *result) {
                    
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
    return _loginclickCommand;
}

-(RACSubject *)loginclickSubject{
    if (!_loginclickSubject) {
        _loginclickSubject = [RACSubject subject];
    }
    return _loginclickSubject;
}

-(RACSubject *)netFailSubject{
    if (!_netFailSubject) {
        _netFailSubject = [RACSubject subject];
    }
    return _netFailSubject;
}

-(RACSubject *)loginNumclickFail{
    if (!_loginNumclickFail) {
        _loginNumclickFail = [RACSubject subject];
    }
    return _loginNumclickFail;
}

-(RACSubject *)loginclickFail{
    if (!_loginclickFail) {
        _loginclickFail = [RACSubject subject];
    }
    return _loginclickFail;
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
