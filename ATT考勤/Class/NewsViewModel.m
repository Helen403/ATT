//
//  NewsViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "NewsViewModel.h"
#import "NewsModel.h"

@implementation NewsViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        [self.successSubject sendNext:result];
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
    
}


-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"News" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [NewsModel mj_objectArrayWithKeyValuesArray:data];
        
    }
    return _arr;
}

-(RACSubject *)cellclickSubject{
    
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}


-(RACSubject *)successSubject{
    
    if (!_successSubject) {
        _successSubject = [RACSubject subject];
    }
    return _successSubject;
}



- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                
                NSString *body1 =[NSString stringWithFormat: @"<findAnnounceNumber xmlns=\"http://service.webservice.vada.com/\">\
                                  <companyCode xmlns=\"\">%@</companyCode>\
                                  </findAnnounceNumber>",self.companyCode];
                
                [self SOAPData:findAnnounceNumber soapBody:body1 success:^(NSString *result) {
                    NSString *announceNumber = [self getFilterOneStr:result filter:@"String"];
                    NSMutableArray *arr = [NSMutableArray array];
                    NewsModel *newsModel1 = self.arr[0];
                    newsModel1.number = announceNumber;
                    [arr addObject:newsModel1];
                    
                    NSString *body2 =[NSString stringWithFormat: @"<findNoticeNumber xmlns=\"http://service.webservice.vada.com/\">\
                                      <companyCode xmlns=\"\">%@</companyCode>\
                                      </findNoticeNumber>",self.companyCode];
                    [self SOAPData: findNoticeNumber soapBody:body2 success:^(NSString *result) {
                        
                        NSString *noticeNumber = [self getFilterOneStr:result filter:@"String"];
                        NewsModel *newsModel2 = self.arr[1];
                        newsModel2.number = noticeNumber;
                        [arr addObject:newsModel2];
                        
                        
                        NSString *body3 =[NSString stringWithFormat: @"<findNewsNumber xmlns=\"http://service.webservice.vada.com/\">\
                                          <companyCode xmlns=\"\">%@</companyCode>\
                                          <userCode xmlns=\"\">%@</userCode>\
                                          </findNewsNumber>",self.companyCode,self.userCode];
                        [self SOAPData: findNewsNumber soapBody:body3 success:^(NSString *result) {
                            NSString *newsNumber = [self getFilterOneStr:result filter:@"String"];
                            NewsModel *newsModel3 = self.arr[2];
                            newsModel3.number = newsNumber;
                            [arr addObject:newsModel3];
                            self.arr = arr;
                            [subscriber sendNext:result];
                            [subscriber sendCompleted];
                        } failure:^(NSError *error) {
                            DismissHud();
                            ShowErrorStatus(@"请检查网络状态");
                            [subscriber sendNext:@"netFail"];
                            [subscriber sendCompleted];
                        }];
                    } failure:^(NSError *error) {
                        DismissHud();
                        ShowErrorStatus(@"请检查网络状态");
                        [subscriber sendNext:@"netFail"];
                        [subscriber sendCompleted];
                    }];
                    
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



@end
