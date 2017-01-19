//
//  PendingCellViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/28.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "PendingCellViewModel.h"
#import "PendingModel.h"

@implementation PendingCellViewModel

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
           //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Pending" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
       _arr= [PendingModel mj_objectArrayWithKeyValuesArray:data];
       
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
