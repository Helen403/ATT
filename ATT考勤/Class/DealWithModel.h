//
//  DealWithModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/29.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealWithModel : NSObject

@property(nonatomic,strong) NSString *Img;

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *number;

+ (instancetype)dealWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
