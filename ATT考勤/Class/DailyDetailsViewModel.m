//
//  DailyDetailsViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DailyDetailsViewModel.h"

@implementation DailyDetailsViewModel
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
   
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }

        NSDictionary *xmlDoc = [self getFilter:result filter:@"MyDayReportDetailModel"];
        
        DailyDetailsModel *dailyDetailsModel = [DailyDetailsModel mj_objectWithKeyValues:xmlDoc];
        self.dailyDetailsModel = dailyDetailsModel;
        [self.successSubject sendNext:result];

    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
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
                
                NSString *body =[NSString stringWithFormat: @"<findMyDayReportDetail xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 <busDate xmlns=\"\">%@</busDate>\
                                 </findMyDayReportDetail>",self.companyCode,self.userCode,self.busDate];
                
                [self SOAPData:findMyDayReportDetail soapBody:body success:^(NSString *result) {
                    
                    
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

-(RACSubject *)successSubject{
    if (!_successSubject) {
        _successSubject = [RACSubject subject];
    }
    return _successSubject;
}

@end
