//
//  RefuseModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefuseModel : NSObject

@property (nonatomic , copy) NSString              * applyDateDesc;
@property (nonatomic , copy) NSString              * userName;
@property (nonatomic , copy) NSString              * userCode;
@property (nonatomic , copy) NSString              * applyLsh;
@property (nonatomic , copy) NSString              * applyMsg;
@property (nonatomic , copy) NSString              * applyType;
@property (nonatomic , copy) NSString              * applyDate;
@property (nonatomic , copy) NSString              * applyStatus;

@property(nonatomic  , strong) UIColor *empColor;

@end
