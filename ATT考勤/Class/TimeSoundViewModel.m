//
//  TimeSoundViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/15.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TimeSoundViewModel.h"
#import "TimeSoundModel.h"

@implementation TimeSoundViewModel


-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array] ;
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Sound" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [TimeSoundModel mj_objectArrayWithKeyValuesArray:data];
    }
    return _arr;
}

@end
