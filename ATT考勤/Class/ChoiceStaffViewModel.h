//
//  ChoiceStaffViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ChoiceStaffViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *deptCode;

@property(nonatomic,strong) RACSubject *tableViewSubject;


//==================================
@property (nonatomic,strong)NSMutableArray *selectorPatnArray;//存放选中数据

@property(nonatomic,strong) RACSubject *sendSubject;

@end
