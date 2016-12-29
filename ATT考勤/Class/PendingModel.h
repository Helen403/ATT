//
//  PendingModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/28.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PendingModel : NSObject


@property(nonatomic,strong) NSString *time;

@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *status;

+ (instancetype)pengingWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
