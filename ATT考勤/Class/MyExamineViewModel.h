//
//  MyExamineViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface MyExamineViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@property(nonatomic,strong) RACCommand *LrefreshDataCommand;

@property(nonatomic,strong) RACCommand *ArefreshDataCommand;

@property(nonatomic,strong) RACCommand *RrefreshDataCommand;

@property(nonatomic,strong) RACCommand *CrefreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) RACSubject *tableViewSubject;
@end
