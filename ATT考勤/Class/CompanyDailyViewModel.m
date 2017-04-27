//
//  CompanyDailyViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CompanyDailyViewModel.h"
#import "CompanyDailyModel.h"

@implementation CompanyDailyViewModel
#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return ;
        }
        
        NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findCompanyDayReportResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findCompanyDayReportResponse>"];
        
        NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[CompanyDailyModel class] rowRootName:@"DeptDayReportModels"];
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
                
                NSString *body =[NSString stringWithFormat: @"<findCompanyDayReport xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 </findCompanyDayReport>",self.companyCode];
                
                [self SOAPData:findDeptDayReport soapBody:body success:^(NSString *result) {
                    
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


-(RACSubject *)cellclickSubject{
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}
@end
