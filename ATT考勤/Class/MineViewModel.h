//
//  MineViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface MineViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *telphone;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) RACSubject *failSubject;

/***************************************/

@property(nonatomic,strong) RACCommand *findSignCommand;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) RACSubject *successSignSubject;


/***************************************/

@property(nonatomic,strong) RACCommand *cardScoreCommand;

/***************************************/

@property(nonatomic,strong) RACCommand *myHoldaysCommand;


//======================================
@property(nonatomic,strong) RACCommand *updataCommand;

@property(nonatomic,strong) NSString *fileName;

@property(nonatomic,strong) NSString *content;

@property(nonatomic,strong) NSString *fileType;


@property(nonatomic,strong) RACSubject *fileSubject;


//=====================================

@property(nonatomic,strong) NSString *companyCode;
@property(nonatomic,strong) NSString *imagePath;
@property(nonatomic,strong) RACCommand *modifyMyImageCommand;

//=================================

@property(nonatomic,strong) RACCommand *findImageCommand;


@property(nonatomic,strong) RACSubject *imgSubject;
@end
