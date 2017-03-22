//
//  DailyDetailsViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"
#import "DailyDetailsModel.h"

@interface DailyDetailsViewModel : HViewModel

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) NSString *busDate;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) DailyDetailsModel *dailyDetailsModel;

@end
