//
//  ChangeViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/2/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ChangePasswordViewModel : HViewModel

@property (nonatomic, strong) RACCommand *sendclickCommand;

@property(nonatomic,strong) NSString *telphone;

@property(nonatomic,strong) NSString *newpassword;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) RACSubject *failSubject;

@end
