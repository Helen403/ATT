//
//  TeamOutWorkDetailsModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamOutWorkDetailsModel : NSObject

@property (nonatomic , copy) NSString              * outAddress;
@property (nonatomic , copy) NSString              * endDate;
@property (nonatomic , copy) NSString              * locLatitude;
@property (nonatomic , copy) NSString              * startDate;
@property (nonatomic , copy) NSString              * empCode;
@property (nonatomic , copy) NSString              * month;
@property (nonatomic , copy) NSString              * locAddress;
@property (nonatomic , copy) NSString              * locLongitude;
@property (nonatomic , copy) NSString              * cloclMode;
@property (nonatomic , copy) NSString              * empName;

@end
