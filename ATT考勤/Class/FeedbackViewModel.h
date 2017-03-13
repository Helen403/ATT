//
//  FeedbackViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface FeedbackViewModel : HViewModel

@property(nonatomic,strong) RACCommand *feedbackCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) RACSubject *submitclickSubject;

@property(nonatomic,strong) NSMutableArray *arr;

@end
