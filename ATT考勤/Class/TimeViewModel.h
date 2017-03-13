//
//  TimeViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface TimeViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@property(nonatomic,strong) RACSubject *tableViewSubject;

@property(nonatomic,strong) RACCommand *modifyCommand;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *userCode;

@end
