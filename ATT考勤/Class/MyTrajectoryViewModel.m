//
//  MyTrajectoryViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyTrajectoryViewModel.h"
#import "MyTrajectoryModel.h"

@implementation MyTrajectoryViewModel
#pragma mark private
-(void)h_initialize{
    
    [self.trajectoryCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<200) {
            
        }else{
            NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAttendRecordByUserMonthResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAttendRecordByUserMonthResponse>"];
            
            NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[MyTrajectoryModel class] rowRootName:@"AttendCardRecords"];
            self.arrTrajectory = arr;
            NSNumber *row =[NSNumber numberWithInteger:1];
            [self.trajectorySubject sendNext:row];
        }
        
    }];
    
    
    [[[self.trajectoryCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            ShowMaskStatus(@"正在拼命加载");
        }
    }];
}


#pragma mark lazyload
-(RACCommand *)trajectoryCommand{
    if (!_trajectoryCommand) {
        
        _trajectoryCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *body =[NSString stringWithFormat: @"<findAttendRecordByUserMonth xmlns=\"http://service.webservice.vada.com/\">\
                                 <companyCode xmlns=\"\">%@</companyCode>\
                                 <userCode xmlns=\"\">%@</userCode>\
                                 <cardMonth xmlns=\"\">%@</cardMonth>\
                                 </findAttendRecordByUserMonth>",self.companyCode,self.userCode,self.cardMonth];
                
                [self SOAPData:findAttendRecordByUserMonth soapBody:body success:^(NSString *result) {
                    
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
    return _trajectoryCommand;
}


-(RACSubject *)trajectorySubject{
    if (!_trajectorySubject) {
        _trajectorySubject = [RACSubject subject] ;
    }
    return _trajectorySubject;
}


@end
