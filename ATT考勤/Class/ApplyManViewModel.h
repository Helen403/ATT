//
//  ApplyManViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ApplyManViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@end
