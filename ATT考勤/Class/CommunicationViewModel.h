//
//  CommunicationViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/4/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface CommunicationViewModel : HViewModel

@property(nonatomic,strong) RACSubject *tableViewSubject;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@property(nonatomic,strong) RACSubject *myTeamSubject;

@property(nonatomic,strong) RACSubject *searchSubject;

@property(nonatomic,strong) RACSubject *myCompanySubject;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *myEmpCode;

@property(nonatomic,strong) NSMutableArray *arr;

@end
