//
//  CreateViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "CreateViewModel.h"

@implementation CreateViewModel

#pragma mark private
-(void)h_initialize{
    
    
    [self.sendclickCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
        //NSLog(@"%@",result);
      
        DismissHud();

        [[NSUserDefaults standardUserDefaults] setObject:xmlDoc forKey:@"returnCode"];

        [self.buildRoleclickSubject sendNext:nil];
        
    }];
    
    
    [[[self.sendclickCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}



-(RACSubject *)buildRoleclickSubject{
    if (!_buildRoleclickSubject) {
        _buildRoleclickSubject = [RACSubject subject];
    }
    return _buildRoleclickSubject;
}


#pragma mark lazyload
-(RACCommand *)sendclickCommand{
    if (!_sendclickCommand) {
        
        _sendclickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<saveUser xmlns=\"http://service.webservice.vada.com/\">\
                                 <telphone xmlns=\"\">%@</telphone>\
                                 <userNickName xmlns=\"\">%@</userNickName>\
                                 <userPassword xmlns=\"\">%@</userPassword>\
                                 </saveUser>",self.telphone,self.name,self.pwd];
                
                [self SOAPData:saveUser soapBody:body success:^(NSString *result) {
                    
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
