//
//  CompanyDailyDetailsViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CompanyDailyDetailsViewModel.h"
#import "CompanyDailyDetailsModel.h"

@implementation CompanyDailyDetailsViewModel
#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findCompanyDayReportDetailResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findCompanyDayReportDetailResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[CompanyDailyDetailsModel class] rowRootName:@"DeptDayReportDetailModels"];
        self.arr = arr;
        
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
                
                NSString *body =[NSString stringWithFormat: @"<findCompanyDayReportDetail xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <cardDate xmlns=\"\">%@</cardDate>\
                                 </findCompanyDayReportDetail>",self.companyCode,self.self.cardDate];
                
                [self SOAPData:findCompanyDayReportDetail soapBody:body success:^(NSString *result) {

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
