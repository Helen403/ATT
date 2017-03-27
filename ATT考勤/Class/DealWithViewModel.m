//
//  DealWithViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/29.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "DealWithViewModel.h"
#import "DealWithModel.h"


@implementation DealWithViewModel





-(RACSubject *)cellclickSubject{
    
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}


-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DealWith" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [DealWithModel mj_objectArrayWithKeyValuesArray:data];
        
    }
    return _arr;
}


@end
