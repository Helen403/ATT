//
//  ForgetViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ForgetViewModel : HViewModel

@property(nonatomic,strong) RACSubject *forgetPwdclickSubject;

@property (nonatomic, strong) RACCommand *sendclickCommand;

@property(nonatomic,strong) NSString *user;

@property(nonatomic,strong) RACSubject *SMSbackSubject;

@property(nonatomic,strong) RACSubject *telphoneBackFailSubject;


@end
