//
//  CheckViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/12.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface CheckViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) NSMutableArray *arrList;

@property(nonatomic,strong) NSMutableArray *arrCount;

@property(nonatomic,strong) NSMutableArray *arrContrast;

@property(nonatomic,strong) NSMutableArray *arrTrajectory;

@property(nonatomic,strong) RACSubject *cellclickSubject;

//==========================================
@property(nonatomic,strong) RACCommand *trajectoryCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) NSString *cardMonth;

@property(nonatomic,strong) RACSubject *trajectorySubject;



@end
