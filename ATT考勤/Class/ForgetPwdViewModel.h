//
//  ForgetPwdViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ForgetPwdViewModel : HViewModel

@property(nonatomic,strong) RACSubject *finishclickSubject;

@property (nonatomic, strong) RACCommand *sendclickCommand;

@property(nonatomic,strong) NSString *pwd;

@property(nonatomic,strong) NSString *telphone;

@end
