//
//  DailyModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyModel : NSObject
@property (nonatomic , copy) NSString              * offWorkCount;
@property (nonatomic , copy) NSString              * shiftName;
@property (nonatomic , copy) NSString              * outWorkCount;
@property (nonatomic , copy) NSString              * earlyWorkCount;
@property (nonatomic , copy) NSString              * lateWorkCount;
@property (nonatomic , copy) NSString              * goOutWorkCount;
@property (nonatomic , copy) NSString              * forgetWorkCount;
@property (nonatomic , copy) NSString              * overWorkCount;
@property (nonatomic , copy) NSString              * cardDate;
@end
