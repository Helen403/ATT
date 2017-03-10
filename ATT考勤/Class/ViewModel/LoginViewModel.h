//
//  LoginViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/22.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface LoginViewModel : HViewModel

@property (nonatomic, strong) RACSubject *loginclickSubject;

@property (nonatomic, strong) RACCommand *loginclickCommand;

@property(nonatomic,strong) NSString *user;

@property(nonatomic,strong) NSString *pwd;

@property(nonatomic,strong) RACSubject *loginclickFail;

@property(nonatomic,strong) RACSubject *loginNumclickFail;

@property(nonatomic,strong) RACSubject *forgetclickSubject;

@property(nonatomic,strong) RACSubject *newpartclickSubject;

@property(nonatomic,strong) RACSubject *weixinclickSubject;

@property(nonatomic,strong) RACSubject *qqclickSubject;

@property(nonatomic,strong) RACSubject *sinaclickSubject;

@property(nonatomic,strong) RACSubject *netFailSubject;

@end
