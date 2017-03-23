//
//  TeamOutWork.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamOutWorkModel : NSObject

@property (nonatomic , copy) NSString              * deptName;
@property (nonatomic , copy) NSString              * outWorkCount;
@property (nonatomic , copy) NSString              * startDate;
@property (nonatomic , copy) NSString              * month;
@property (nonatomic , copy) NSString              * endDate;
@property (nonatomic , copy) NSString              * deptCode;

@end
