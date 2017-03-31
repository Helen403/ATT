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

/*************************************/

@property (nonatomic, strong) RACCommand *attendRecordCommand;


@property(nonatomic,strong) NSString *cardDate;

@property(nonatomic,strong) NSString *cardTime;
@property(nonatomic,strong) NSString *cardDeviceType;
@property(nonatomic,strong) NSString *cardDeviceName;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *clockMode;
@property(nonatomic,strong) NSString *deptName;
@property(nonatomic,strong) NSString *locLongitude;
@property(nonatomic,strong) NSString *locLatitude;
@property(nonatomic,strong) NSString *locAddress;
@property(nonatomic,strong) NSString *timePhase;
@property(nonatomic,strong) NSString *timePoint;
@property(nonatomic,strong) NSString *cardStatus;

@property(nonatomic,strong) RACSubject *attendRecordSuccessSubject;

@property(nonatomic,strong) RACSubject *attendRecordFailSubject;


/**************************************/

@property(nonatomic,strong) RACCommand *findAttendRecordByUserDateCommand;

@property(nonatomic,strong) NSMutableArray *arrAttendRecord;

@property(nonatomic,strong) RACSubject *attendRecordSubject;

@property(nonatomic,strong) RACSubject *attendFailSubject;

/**************************************/
@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) RACSubject *personalSubject;

@property(nonatomic,strong) RACSubject *notSubject;

@property(nonatomic,strong) RACCommand *scheduCommand;



@property(nonatomic,strong) RACCommand *findImageCommand;

@property(nonatomic,strong) RACSubject *findImgSubject;

@end
