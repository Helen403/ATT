//
//  DailyDetailsModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardDetaillist.h"

@interface DailyDetailsModel : NSObject

@property (nonatomic , strong) NSArray<CardDetaillist *>              * cardDetaillist;
@property (nonatomic , copy) NSString              * signCount;
@property (nonatomic , copy) NSString              * goOutWorkHours;
@property (nonatomic , copy) NSString              * overWorkHours;
@property (nonatomic , copy) NSString              * workHours;
@property (nonatomic , copy) NSString              * shiftName;

@end
