//
//  ApplyViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ApplyViewModel : HViewModel

@property(nonatomic,strong) RACSubject *myApplyclickSubject;

@property(nonatomic,strong) RACSubject *myExamineclickSubject;

@end
