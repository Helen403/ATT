//
//  AskViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AskViewModel.h"
#import "AskModel.h"

@implementation AskViewModel

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DealWith" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr = [AskModel mj_objectArrayWithKeyValuesArray:data];
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
