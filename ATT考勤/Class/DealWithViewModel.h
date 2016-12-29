//
//  DealWithViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/29.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface DealWithViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@end
