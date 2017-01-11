//
//  EmployeeViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/10.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface EmployeeViewModel : HViewModel


@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@end
