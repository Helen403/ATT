//
//  ChatViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChatViewModel.h"
#import "ChatModel.h"

@implementation ChatViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findMyMsgResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findMyMsgResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[ChatModel class] rowRootName:@"Newss"];
        if (arr.count != self.arr.count) {
            self.arr = arr;
            [self.successSubject sendNext:nil];
        }

    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    [self.sendCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
        
//        NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
//        if ([xmlDoc isEqualToString:@"0"]) {
//             //[self.successSubject sendNext:nil];
//        }
       
    }];
}


- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                
                NSString *body =[NSString stringWithFormat: @"<findMyMsg xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 <targetId xmlns=\"\">%@</targetId>\
                                 </findMyMsg>",self.companyCode,self.userCode,self.targetId];
                
                [self SOAPData:findMyMsg soapBody:body success:^(NSString *result) {
                    
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
    return _refreshDataCommand;
}


- (RACCommand *)sendCommand {
    
    if (!_sendCommand) {
        
        @weakify(self);
        _sendCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                
                NSString *body =[NSString stringWithFormat: @"<saveMessage xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <msgSenderId xmlns=\"\">%@</msgSenderId>\
                                 <msgSenderName xmlns=\"\">%@</msgSenderName>\
                                  <msgReceId xmlns=\"\">%@</msgReceId>\
                                  <msgReceName xmlns=\"\">%@</msgReceName>\
                                  <msgSendDate xmlns=\"\">%@</msgSendDate>\
                                  <msgType xmlns=\"\">%@</msgType>\
                                  <msgContents xmlns=\"\">%@</msgContents>\
                                  <msgVolumnTime xmlns=\"\">%@</msgVolumnTime>\
                                 </saveMessage>",self.companyCode,self.msgSenderId,self.msgSenderName,self.msgReceId,self.msgReceName,self.msgSendDate,self.msgType,self.msgContents,self.msgVolumnTime];
                
                [self SOAPData:saveMessage soapBody:body success:^(NSString *result) {
                    
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
    return _sendCommand;
}

-(RACSubject *)successSubject{
    if (!_successSubject) {
        _successSubject = [RACSubject subject];
    }
    return _successSubject;
}


-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

@end
