//
//  AuditingViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AuditingViewModel.h"
#import "AuditingModel.h"

@implementation AuditingViewModel

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DealWith" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr = [AuditingModel mj_objectArrayWithKeyValuesArray:data];
        
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
