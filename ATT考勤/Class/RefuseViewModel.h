//
//  RefuseViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface RefuseViewModel : HViewModel

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *tableViewSubject;

@property(nonatomic,strong) RACSubject *cellclickSubject;


@end
