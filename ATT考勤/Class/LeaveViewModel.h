//
//  LeaveViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface LeaveViewModel : HViewModel

@property(nonatomic,strong) RACSubject *submitclickSubject;

@property(nonatomic,strong) NSMutableArray *arr;

@end
