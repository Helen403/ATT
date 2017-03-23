//
//  TeamDailyModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamDailyModel : NSObject

@property (nonatomic , copy) NSString              * offWorkCount;
@property (nonatomic , copy) NSString              * outWorkCount;
@property (nonatomic , copy) NSString              * deptName;
@property (nonatomic , copy) NSString              * earlyWorkCount;
@property (nonatomic , copy) NSString              * deptCode;
@property (nonatomic , copy) NSString              * lateWorkCount;
@property (nonatomic , copy) NSString              * forgetWorkCount;
@property (nonatomic , copy) NSString              * deptPersonCount;
@property (nonatomic , copy) NSString              * busDate;
@property (nonatomic , copy) NSString              * goOutWorkCount;
@property (nonatomic , copy) NSString              * overWorkCount;

@end
