//
//  AboutViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface AboutViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@end
