//
//  NoticeViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "NoticeViewModel.h"
#import "AnnouncementModel.h"


@implementation NoticeViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAllAnnounceResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAllAnnounceResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[AnnouncementModel class] rowRootName:@"Announcements"];
        self.arr = arr;
        [self.successSubject sendNext:result];
        
        DismissHud();
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
                
                NSString *body =[NSString stringWithFormat: @"<findAllAnnounce xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 </findAllAnnounce>",self.companyCode];
                
                [self SOAPData:findAllAnnounce soapBody:body success:^(NSString *result) {
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
    
    return _refreshDataCommand;
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
