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

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DealWith" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        for (NSDictionary *dict in data) {
            // 3.1.创建模型对象
            
            DealWithModel *myExamine = [DealWithModel dealWithDict:dict];
            // 3.2.添加模型对象到数组中
            [_arr addObject:myExamine];
        }
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
