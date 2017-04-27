//
//  StatisticsViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"
#import "UserAuthorModel.h"

@interface StatisticsViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) UserAuthorModel *userAuthorModel;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;


@end
