//
//  MyOpinionViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyOpinionViewModel.h"

@implementation MyOpinionViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.suggbackCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();

        
        NSString *xmlDoc = [self getFilterOneStr:result filter:@"String"];
        if ([xmlDoc isEqualToString:@"0"]) {
            ShowMessage(@"意见反馈提交成功");
        }else{
            ShowMessage(@"意见反馈提交失败");
        }
        [self.submitclickSubject sendNext:nil];

    }];
    
    
    [[[self.suggbackCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
  
}

- (RACCommand *)suggbackCommand {
    
    if (!_suggbackCommand) {
        
        @weakify(self);
        _suggbackCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<saveSuggback xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <suggTypeId xmlns=\"\">%@</suggTypeId>\
                                 <suggQuestion xmlns=\"\">%@</suggQuestion>\
                                 <suggTelphone xmlns=\"\">%@</suggTelphone>\
                                 <suggUserCode xmlns=\"\">%@</suggUserCode>\
                                 <suggDatetime xmlns=\"\">%@</suggDatetime>\
                                 </saveSuggback>",self.companyCode,self.suggTypeId,self.suggQuestion,self.suggTelphone,self.suggUserCode,self.suggDatetime];
                
                [self SOAPData:saveApplyOverTime soapBody:body success:^(NSString *result) {
                    
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
    return _suggbackCommand;
}


-(RACSubject *)submitclickSubject{
    if (!_submitclickSubject) {
        _submitclickSubject = [RACSubject subject] ;
    }
    return _submitclickSubject;
}

@end
