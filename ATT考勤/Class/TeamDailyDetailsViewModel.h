//
//  TeamDailyDetailsViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface TeamDailyDetailsViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *deptCode;

@property(nonatomic,strong) NSString *cardDate;


@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) RACSubject *cellclickSubject;
@end
