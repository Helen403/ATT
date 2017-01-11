//
//  EmployeeViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/10.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "EmployeeViewModel.h"
#import "EmployeeModel.h"

@implementation EmployeeViewModel
-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Employee" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [EmployeeModel mj_objectArrayWithKeyValuesArray:data];
        
    }
    return _arr;
}

-(RACSubject *)cellclickSubject{
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}


@end
