//
//  BuildRoleViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface BuildRoleViewModel : HViewModel

@property(nonatomic,strong) RACSubject *companyCodeclickSubject;

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) NSString *returnCode;

@end
