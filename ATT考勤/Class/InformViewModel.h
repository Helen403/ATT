//
//  InformViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface InformViewModel : HViewModel

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) NSMutableArray *arr;
@end
