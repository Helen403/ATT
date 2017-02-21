//
//  HomeViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/21.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"
#import "EmpModel.h"
#import "Dept.h"
#import "AttendWorkShift.h"
#import "AttendWorkShiftDetail.h"


@interface HomeViewModel : HViewModel

@property(nonatomic,strong) RACSubject *headclickSubject;

@property(nonatomic,strong) RACSubject *setClickSubject;

@property (nonatomic, strong) RACCommand *sendclickCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) RACSubject *resultSubject;


@property(nonatomic,strong) NSString *deptCode;

@property(nonatomic,strong) NSString *empCode;

@property(nonatomic,strong) NSString *curYear;

@property(nonatomic,strong) NSString *curMonth;

@property(nonatomic,strong) NSString *curDay;

@property(nonatomic,strong) NSString *shiftLsh;

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong)  EmpModel *empModel;

@property(nonatomic,strong) Dept *dept;

@property(nonatomic,strong) AttendWorkShift *attendWorkShift;

@end
