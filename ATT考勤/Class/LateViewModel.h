//
//  ApplicationViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface LateViewModel : HViewModel

@property(nonatomic,strong) RACSubject *submitclickSubject;

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) RACSubject *tableViewSubject;



//===========================================

@property(nonatomic,strong) RACCommand *applyLateCommand;

@property(nonatomic,strong) NSString *applyStartDatetime;
@property(nonatomic,strong) NSString *applyEndDatetime;
@property(nonatomic,strong) NSString *applyLenHours;
@property(nonatomic,strong) NSString *applyReason;
@property(nonatomic,strong) NSString *applyStatus;
@property(nonatomic,strong) NSString *flowInstanceId;
@property(nonatomic,strong) NSString *cuserCode;
@property(nonatomic,strong) NSString *cuserName;
@property(nonatomic,strong) NSString *workLsh;
@property(nonatomic,strong) NSString *workName;
@property(nonatomic,strong) NSString *applyUserCode;
@property(nonatomic,strong) NSString *applyUserName;


@property(nonatomic,strong) NSString *changeDatetime;
@property(nonatomic,strong) NSString *shiftOldLsh;
@property(nonatomic,strong) NSString *shiftOldName;
@property(nonatomic,strong) NSString *shiftNewLsh;
@property(nonatomic,strong) NSString *shiftNewName;
@end
