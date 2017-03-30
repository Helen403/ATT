//
//  MyContrastViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface MyContrastViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arrContrast;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) NSString *cardMonth;

@end
