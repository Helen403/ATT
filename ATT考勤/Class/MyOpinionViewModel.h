//
//  MyOpinionViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface MyOpinionViewModel : HViewModel

@property(nonatomic,strong) RACCommand *suggbackCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *suggTypeId;

@property(nonatomic,strong) NSString *suggQuestion;

@property(nonatomic,strong) NSString *suggTelphone;

@property(nonatomic,strong) NSString *suggUserCode;

@property(nonatomic,strong) NSString *suggDatetime;

@property(nonatomic,strong) RACSubject *submitclickSubject;

@end
