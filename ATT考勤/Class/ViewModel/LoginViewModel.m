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

       NSDictionary *xmlDoc = [self getFilter:result filter:@"Users"];
       UserModel *model = [UserModel mj_objectWithKeyValues:xmlDoc];
        NSLog(@"asd");
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


-(NSDictionary *)getFilter:(NSString *)result filter:(NSString *)filter{
 
    NSString *str1 = [NSString stringWithFormat:@"<%@>",filter];
    NSRange range1 = [result rangeOfString:str1];//匹配得到的下标
    NSString *str2 = [NSString stringWithFormat:@"</%@>",filter];
    NSRange range2 = [result rangeOfString:str2];//匹配得到的下标
    
    result = [result substringToIndex:range2.location+range2.length];
    result = [result substringFromIndex:range1.location];
    
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:result];

    return xmlDoc;
}

#pragma mark lazyload
-(RACCommand *)loginclickCommand{
    if (!_loginclickCommand) {
        
        _loginclickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<findUserByUserTelphone xmlns=\"http://service.security.vada.com/\">\
                <userTelphone xmlns=\"\">%@</userTelphone>\
                </findUserByUserTelphone>",self.user];
                
                [self SOAPData:Login soapBody:body success:^(NSString *result) {
                    
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];
                } failure:^(NSError *error) {
                    NSLog(@"%@",error);
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
