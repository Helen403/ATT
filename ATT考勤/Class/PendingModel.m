//
//  PendingModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/28.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "PendingModel.h"

@implementation PendingModel

+ (instancetype)pengingWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        // 赋值标题
        self.time = dict[@"time"];
        self.name = dict[@"name"];
        self.status = dict[@"status"];
    }
    return self;
}

@end
