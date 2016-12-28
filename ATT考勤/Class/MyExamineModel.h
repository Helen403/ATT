//
//  MyExamineModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/28.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyExamineModel : NSObject

@property(nonatomic,strong) NSString *Img;

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *hint;

+ (instancetype)examineWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
