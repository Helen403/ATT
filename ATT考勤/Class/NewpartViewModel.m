//
//  NewpartViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "NewpartViewModel.h"
#import "GDataXMLNode.h"


@implementation NewpartViewModel

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
    
}

-(RACSubject *)telphoneBackFailSubject{
    if (!_telphoneBackFailSubject) {
        _telphoneBackFailSubject = [RACSubject subject];
    }
    return _telphoneBackFailSubject;
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
                NSString *body =[NSString stringWithFormat: @"<findUserByTelphone xmlns=\"http://service.webservice.vada.com/\">\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 </findUserByTelphone>",self.user];
                
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
