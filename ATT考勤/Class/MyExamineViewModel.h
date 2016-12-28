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
@end
