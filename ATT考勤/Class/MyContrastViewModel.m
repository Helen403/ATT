//
//  MyContrastViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyContrastViewModel.h"
#import "MyContrastModel.h"

@implementation MyContrastViewModel

#pragma mark private
-(void)h_initialize{
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<200) {
            
        }else{
            NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAttendWorkHourByUserMonthResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAttendWorkHourByUserMonthResponse>"];
            
            NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[MyContrastModel class] rowRootName:@"ChartModels"];
            self.arrContrast = arr;
            NSNumber *row =[NSNumber numberWithInteger:1];
            [self.successSubject sendNext:nil];
        }
        
    }];
    
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
}


#pragma mark lazyload
-(RACCommand *)refreshDataCommand{
    if (!_refreshDataCommand) {
        
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<findAttendWorkHourByUserMonth xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 <cardMonth xmlns=\"\">%@</cardMonth>\
                                 </findAttendWorkHourByUserMonth>",self.companyCode,self.userCode,self.cardMonth];
                
                [self SOAPData:findAttendWorkHourByUserMonth soapBody:body success:^(NSString *result) {
                    
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

-(NSMutableArray *)arrContrast{
    if (!_arrContrast) {
        _arrContrast = [NSMutableArray array] ;
        
    }
    return _arrContrast;
}

-(RACSubject *)successSubject{
    if (!_successSubject) {
        _successSubject = [RACSubject subject] ;
    }
    return _successSubject;
}


@end
