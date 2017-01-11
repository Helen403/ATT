//
//  PersonalViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "PersonalViewModel.h"
#import "PersonalModel.h"

@implementation PersonalViewModel

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Personal" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [PersonalModel mj_objectArrayWithKeyValuesArray:data];
        
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
