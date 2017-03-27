//
//  ChoiceStaffViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ChoiceStaffTeamViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) RACSubject *tableViewSubject;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@property(nonatomic,strong) RACCommand *CrefreshDataCommand;

@property(nonatomic,strong) NSMutableArray *arrTmp;

@property(nonatomic,assign) NSInteger index;
@end
