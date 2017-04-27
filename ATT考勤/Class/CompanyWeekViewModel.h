//
//  CompanyWeekViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface CompanyWeekViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@end
