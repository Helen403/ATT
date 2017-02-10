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

//#import "NSXmlKit/NSXmlKit.h"



@implementation LoginViewModel

#pragma mark private
-(void)h_initialize{
    
    @weakify(self);
    [self.loginclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {

       NSDictionary *xmlDoc = [self getFilter:result filter:@"User"];
      
        UserModel *model = [UserModel mj_objectWithKeyValues:xmlDoc];
        NSString *password = [self.pwd md5String];
       
        @strongify(self);
        if ([self.user isEqualToString:model.userTelphone]&&[password isEqualToString:model.userPassword]) {
            //存储对象
            saveModel(model, @"user");

            [self.loginclickSubject sendNext:nil];
        }else{
            [self.loginclickFail sendNext:nil];
        }
        DismissHud();
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
                </findUserByTelphone>",self.user];
                
                [self SOAPData:Login soapBody:body success:^(NSString *result) {
                    
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
    return _loginclickCommand;
}

-(RACSubject *)loginclickSubject{
    if (!_loginclickSubject) {
        _loginclickSubject = [RACSubject subject];
    }
    return _loginclickSubject;
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
