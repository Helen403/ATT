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
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Trajectory" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arrTrajectory= [TrajectoryModel mj_objectArrayWithKeyValuesArray:data];
        
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

@end
