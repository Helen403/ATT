//
//  CustomViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CustomViewModel.h"
#import "CustomModel.h"

@implementation CustomViewModel


-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Custom" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [CustomModel mj_objectArrayWithKeyValuesArray:data];
        
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
