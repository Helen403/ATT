//
//  MyMsgViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface MyMsgViewModel : HViewModel

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) RACSubject *cellclickSubject;

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) RACCommand *delMsgCommand;

@property(nonatomic,strong) NSString *targetUserCode;

@end
