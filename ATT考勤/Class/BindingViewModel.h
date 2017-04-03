//
//  BindingViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface BindingViewModel : HViewModel


@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) NSString *deviceName;

@property(nonatomic,strong) NSString *changeDeviceName;

@property(nonatomic,strong) NSString *deviceCode;

@property(nonatomic,strong) RACCommand *modifyCommand;

@property(nonatomic,strong) RACSubject *bindSubject;

@end
