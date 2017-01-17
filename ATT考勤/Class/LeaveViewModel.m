//
//  LeaveViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "LeaveViewModel.h"
#import "LeaveModel.h"

@implementation LeaveViewModel

-(RACSubject *)submitclickSubject{
    if (!_submitclickSubject) {
        _submitclickSubject = [RACSubject subject];
    }
    return _submitclickSubject;
}

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Leave" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [LeaveModel mj_objectArrayWithKeyValuesArray:data];
    }
    return _arr;
}


@end
