//
//  MyApplyModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyApplyModel : NSObject

@property(nonatomic,strong) NSString *Img;

@property(nonatomic,strong) NSString *title;

+ (instancetype)applyWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
