//
//  FlowStepChecksModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlowStepChecksModel : NSObject

@property (nonatomic , copy) NSString              * stepUserName;
@property (nonatomic , copy) NSString              * lsh;
@property (nonatomic , copy) NSString              * flowLsh;
@property (nonatomic , copy) NSString              * stepUserCode;
@property (nonatomic , copy) NSString              * stepStatus;
@property (nonatomic , copy) NSString              * stepCheckMsg;
@property (nonatomic , copy) NSString              * flowTypeName;
@property (nonatomic , copy) NSString              * companyCode;
@property (nonatomic , copy) NSString              * stepCheckDate;
@property (nonatomic , copy) NSString              * flowInstanceId;

@end
