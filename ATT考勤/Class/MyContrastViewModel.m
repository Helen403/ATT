//
//  MyContrastViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyContrastViewModel.h"
#import "MyContrastModel.h"

@implementation MyContrastViewModel

-(NSMutableArray *)arrContrast{
    if (!_arrContrast) {
        _arrContrast = [NSMutableArray array] ;
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Contrast" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arrContrast= [MyContrastModel mj_objectArrayWithKeyValuesArray:data];
    }
    return _arrContrast;
}

@end
