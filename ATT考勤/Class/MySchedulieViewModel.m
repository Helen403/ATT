//
//  MySchedulieViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MySchedulieViewModel.h"
#import "MySchedulieModel.h"

@implementation MySchedulieViewModel

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
//        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Calendar" ofType:@"plist"];
//        
//        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
//        
//        _arr= [MySchedulieModel mj_objectArrayWithKeyValuesArray:data];
        
    }
    return _arr;
}

@end
