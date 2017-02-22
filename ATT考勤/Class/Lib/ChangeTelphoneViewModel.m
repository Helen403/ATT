//
//  ChangeTelphoneViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/2/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChangeTelphoneViewModel.h"
#import "GDataXMLNode.h"

@implementation ChangeTelphoneViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.sendclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();

        NSString *xmlDoc = [self getFilterStr:result filter:@"String"];
        NSLog(@"%@",xmlDoc);
        [self.SMSbackSubject sendNext:xmlDoc];
    }];
    
    
    [[[self.sendclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    [self.changeTelphoneCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        
        NSLog(@"%@",result);
        
        GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithXMLString:result options:0 error:nil];
        GDataXMLElement *xmlEle = [xmlDoc rootElement];
        NSArray *array = [xmlEle children];
        
        GDataXMLElement *ele = [array objectAtIndex:0];
        NSArray *array2 =[ele children];
        NSLog(@"%lu",(unsigned long)[array2 count]);
        GDataXMLElement *ele2 = [array2 objectAtIndex:0];
        NSArray *array3 =[ele2 children];
        NSLog(@"%lu",(unsigned long)[array3 count]);
        NSString *str = [ele2 stringValue];
        NSLog(@"%@",str);
    }];
    
    
    [[[self.changeTelphoneCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
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
                
                NSString *body =[NSString stringWithFormat: @"<findUserByTelphone xmlns=\"http://service.webservice.vada.com/\">\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 </findUserByTelphone>",self.telphone];
                
                [self SOAPData:findUserByTelphone soapBody:body success:^(NSString *result) {
                    
                    
                    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithXMLString:result options:0 error:nil];
                    GDataXMLElement *xmlEle = [xmlDoc rootElement];
                    NSArray *array = [xmlEle children];
                    
                    GDataXMLElement *ele = [array objectAtIndex:0];
                    NSArray *array2 =[ele children];
                    
                    GDataXMLElement *ele2 = [array2 objectAtIndex:0];
                    NSArray *array3 =[ele2 children];
                    
                    GDataXMLElement *ele3 = [array3 objectAtIndex:0];
                    NSArray *array4 =[ele3 children];
                    
                    if ([array4 count]>2) {
                        ShowErrorStatus(@"该手机号已注册");
                        [self.telphoneBackFailSubject sendNext:nil];
                        [subscriber sendCompleted];
                    }else{
                        
                        NSString *body =[NSString stringWithFormat: @"<sendValidateSMS xmlns=\"http://service.webservice.vada.com/\">\
                                         <telphone xmlns=\"\">%@</telphone>\
                                         </sendValidateSMS>",self.telphone];
                        
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


-(RACSubject *)telphoneBackFailSubject{
    if (!_telphoneBackFailSubject) {
        _telphoneBackFailSubject = [RACSubject subject];
    }
    return _telphoneBackFailSubject;
}


#pragma mark lazyload
-(RACCommand *)changeTelphoneCommand{
    if (!_changeTelphoneCommand) {
        
        _changeTelphoneCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<modifyUserTelphone xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 </modifyUserTelphone>",self.companyCode,self.userCode,self.telphone];
                
                [self SOAPData:findUserByTelphone soapBody:body success:^(NSString *result) {

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
    return _changeTelphoneCommand;
}


@end
