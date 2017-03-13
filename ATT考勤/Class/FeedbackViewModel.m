//
//  FeedbackViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "FeedbackViewModel.h"
#import "FeedbackModel.h"

@implementation FeedbackViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.feedbackCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAllSuggbackByUserResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllSuggbackByUserResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[FeedbackModel class] rowRootName:@"SuggBacks"];
        self.arr = arr;
       
        [self.submitclickSubject sendNext:nil];
        
    }];
    
    
    [[[self.feedbackCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
    
    
}

- (RACCommand *)feedbackCommand {
    
    if (!_feedbackCommand) {
        
        @weakify(self);
        _feedbackCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body =[NSString stringWithFormat: @"<findAllSuggbackByUser xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findAllSuggbackByUser>",self.companyCode,self.userCode];
                
                [self SOAPData:findAllSuggbackByUser soapBody:body success:^(NSString *result) {
                    
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
    return _feedbackCommand;
}


-(RACSubject *)submitclickSubject{
    if (!_submitclickSubject) {
        _submitclickSubject = [RACSubject subject] ;
    }
    return _submitclickSubject;
}


@end
