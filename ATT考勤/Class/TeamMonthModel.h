//
//  TeamMonthModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamMonthModel : NSObject

@property (nonatomic , copy) NSString              * forgetWorkCount;
@property (nonatomic , copy) NSString              * deptName;
@property (nonatomic , copy) NSString              * weekHours;
@property (nonatomic , copy) NSString              * deptCode;
@property (nonatomic , copy) NSString              * lateWorkCount;
@property (nonatomic , copy) NSString              * endDate;
@property (nonatomic , copy) NSString              * offWorkCount;
@property (nonatomic , copy) NSString              * goOutWorkCount;
@property (nonatomic , copy) NSString              * week;
@property (nonatomic , copy) NSString              * startDate;
@property (nonatomic , copy) NSString              * earlyWorkCount;
@property (nonatomic , copy) NSString              * overWorkCount;
@property (nonatomic , copy) NSString              * outWorkCount;

@end
