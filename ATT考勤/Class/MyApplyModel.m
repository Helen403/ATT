//
//  MyApplyModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "MyApplyModel.h"

@implementation MyApplyModel

+ (instancetype)applyWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        // 赋值标题
        self.title = dict[@"title"];
        self.Img = dict[@"imgtext"];
    }
    return self;
}

@end
