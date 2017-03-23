//
//  HeroModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject

@property (nonatomic , copy) NSString              * empName;
@property (nonatomic , copy) NSString              * empGrade;
@property (nonatomic , copy) NSString              * workHours;
@property (nonatomic , copy) NSString              * empSex;

@property(nonatomic,strong) UIColor * empColor;

@end
