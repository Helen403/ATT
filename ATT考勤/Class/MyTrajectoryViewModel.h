//
//  MyTrajectoryViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface MyTrajectoryViewModel : HViewModel

@property(nonatomic,strong) RACCommand *trajectoryCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) NSString *cardMonth;

@property(nonatomic,strong) RACSubject *trajectorySubject;

@property(nonatomic,strong) NSMutableArray *arrTrajectory;


@end
