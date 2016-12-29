//
//  DealWithModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/29.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "DealWithModel.h"

@implementation DealWithModel

+ (instancetype)dealWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        // 赋值标题
        self.title = dict[@"title"];
        self.Img = dict[@"imgtext"];
        self.number = dict[@"number"];
    }
    return self;
}

@end
