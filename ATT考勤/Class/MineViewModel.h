//
//  MineViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface MineViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *telphone;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) RACSubject *failSubject;


@property(nonatomic,strong) RACCommand *findSignCommand;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) RACSubject *successSignSubject;

@end
