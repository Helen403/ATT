//
//  StartApp.m
//  ATT考勤
//
//  Created by Helen on 16/12/16.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "StartApp.h"

@implementation StartApp

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        [[self class] initPersonData];
        
    });
}

#pragma mark - 初始化个人数据
+ (void)initPersonData {
    
}


@end
