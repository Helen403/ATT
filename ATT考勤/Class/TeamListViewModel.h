//
//  TeamListViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface TeamListViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@end
