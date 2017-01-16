//
//  TrajectoryModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/12.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrajectoryModel : NSObject

@property(nonatomic,strong) NSString *year;

@property(nonatomic,strong) NSString *time1;

@property(nonatomic,strong) NSString *content1;

//经度
@property(nonatomic,strong) NSString *longitude1;

//纬度
@property(nonatomic,strong) NSString *latitude1;

@property(nonatomic,strong) NSString *time2;

@property(nonatomic,strong) NSString *content2;

//经度
@property(nonatomic,strong) NSString *longitude2;

//纬度
@property(nonatomic,strong) NSString *latitude2;

@end
