//
//  AttendWorkShift.h
//  ATT考勤
//
//  Created by Helen on 17/2/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttendWorkShift : NSObject

@property (nonatomic , copy) NSString              * shiftName;
@property (nonatomic , copy) NSString              * allowXLateMinutes;
@property (nonatomic , copy) NSString              * isHuman;
@property (nonatomic , copy) NSString              * shiftDispColor;
@property (nonatomic , copy) NSString              * daySignCount;
@property (nonatomic , copy) NSString              * workHours;
@property (nonatomic , copy) NSString              * shiftNickName;
@property (nonatomic , copy) NSString              * companyCode;
@property (nonatomic , copy) NSString              * shiftLsh;
@property (nonatomic , copy) NSString              * allowEarlyMinutes;
@property (nonatomic , copy) NSString              * allowLateMinutes;

@end
