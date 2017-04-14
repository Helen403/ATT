//
//  MySchedulieViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface MySchedulieViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *shiftWorkArr;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *curYear;

@property(nonatomic,strong) NSString *curMonth;

@property(nonatomic,strong) NSString *empCode;

@property(nonatomic,strong) NSMutableArray *holidayArr;

@end
