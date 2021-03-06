//
//  InformViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "InformViewModel.h"
#import "InformListModel.h"

@implementation InformViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
        NSDictionary *xmlDoc = [self getFilter:result filter:@"Notices"];
        
        NoticeModel *noticeModel = [NoticeModel mj_objectWithKeyValues:xmlDoc];
        self.noticeModel = noticeModel;
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
                
                InformListModel *inform = self.preArr[self.index];
                
                NSString *body =[NSString stringWithFormat: @"<findNoticesById xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <msgId xmlns=\"\">%@</msgId>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findNoticesById>",self.companyCode,inform.msgId,self.userCode];
                
                [self SOAPData:findNoticesById soapBody:body success:^(NSString *result) {
                    
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

-(NSMutableArray *)preArr{
    if (!_preArr) {
        _preArr = [NSMutableArray array] ;
    }
    return _preArr;
}
@end
