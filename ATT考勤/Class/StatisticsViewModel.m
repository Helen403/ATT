//
//  StatisticsViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "StatisticsViewModel.h"
#import "StatisticsModel.h"



@implementation StatisticsViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
        
        NSDictionary *xmlDoc = [self getFilter:result filter:@"AttendWorkShift"];
        
        UserAuthorModel *userAuthorModel = [UserAuthorModel mj_objectWithKeyValues:xmlDoc];
        
        self.userAuthorModel = userAuthorModel;
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
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Statistics" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr = [StatisticsModel mj_objectArrayWithKeyValuesArray:data];
        
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
                
                NSString *body =[NSString stringWithFormat: @"<findUserAuthorByUserCode xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 </findUserAuthorByUserCode>",self.companyCode,self.userCode];
                
                [self SOAPData:findUserAuthorByUserCode soapBody:body success:^(NSString *result) {
                    
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




@end
