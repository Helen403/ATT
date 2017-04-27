//
//  MyMsgViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyMsgViewModel.h"
#import "MyMsgModel.h"

@implementation MyMsgViewModel
#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
      
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findMyMsgListResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findMyMsgListResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[MyMsgModel class] rowRootName:@"MsgListModels"];
        self.arr = arr;
     
        [self.successSubject sendNext:nil];
        
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    [self.delMsgCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
    }];
}


- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                

                NSString *body =[NSString stringWithFormat: @"<findMyMsgList xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findMyMsgList>",self.companyCode,self.userCode];
                
                [self SOAPData:findMyMsgList soapBody:body success:^(NSString *result) {
                    
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

- (RACCommand *)delMsgCommand {
    
    if (!_delMsgCommand) {
        
        @weakify(self);
        _delMsgCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                
                NSString *body =[NSString stringWithFormat: @"<delMyMsgList xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 <targetUserCode xmlns=\"\">%@</targetUserCode>\
                                 </delMyMsgList>",self.companyCode,self.userCode,self.targetUserCode];
                
                [self SOAPData:delMyMsgList soapBody:body success:^(NSString *result) {
                    
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
    return _delMsgCommand;
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

-(RACSubject *)cellclickSubject{
    
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}

@end
