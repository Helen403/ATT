//
//  CheckViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/12.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CheckViewModel.h"
#import "CalendarModel.h"
#import "ListModel.h"
#import "CountModel.h"
#import "ContrastModel.h"
#import "TrajectoryModel.h"



@implementation CheckViewModel
#pragma mark private
-(void)h_initialize{
    
    [self.trajectoryCommand.executionSignals.switchToLatest subscribeNext:^(NSString *result) {
        DismissHud();
        if ([result isEqualToString:@"netFail"]||[result isEqualToString:@""]) {
            return;
        }
        if (result.length<200) {
            NSNumber *row =[NSNumber numberWithInteger:2];
            
            _arrTrajectory = nil;
            [self.trajectorySubject sendNext:row];
        }else{
            NSString *xmlDoc = [self getFilterStr:result filter1:@"<ns2:findAttendRecordByUserMonthResponse xmlns:ns2=\"http://service.webservice.vada.com/\">" filter2:@"</ns2:findAttendRecordByUserMonthResponse>"];
            
            NSMutableArray *arr = [LSCoreToolCenter xmlToArray:xmlDoc class:[TrajectoryModel class] rowRootName:@"AttendCardRecords"];
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



-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Calendar" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [CalendarModel mj_objectArrayWithKeyValuesArray:data];
        
    }
    return _arr;
}

-(NSMutableArray *)arrTrajectory{
    if (!_arrTrajectory) {
        _arrTrajectory = [NSMutableArray array];

    }
    return _arrTrajectory;
}

-(NSMutableArray *)arrContrast{
    if (!_arrContrast) {
        _arrContrast = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Contrast" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arrContrast= [ContrastModel mj_objectArrayWithKeyValuesArray:data];
        
    }
    return _arrContrast;
}


-(NSMutableArray *)arrCount{
    if (!_arrCount) {
        _arrCount = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DealWith" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arrCount= [CountModel mj_objectArrayWithKeyValuesArray:data];
        
    }
    return _arrCount;
}

-(NSMutableArray *)arrList{
    if (!_arrList) {
        _arrList = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"List" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arrList= [ListModel mj_objectArrayWithKeyValuesArray:data];
        
    }
    return _arrList;
}

-(RACSubject *)cellclickSubject{
    
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
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
