//
//  CreateViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface CreateViewModel : HViewModel

@property(nonatomic,strong) RACSubject *buildRoleclickSubject;

@property (nonatomic, strong) RACCommand *sendclickCommand;

@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *pwd;

@property(nonatomic,strong) NSString *telphone;

@property(nonatomic,strong) NSString *phoneDeviceCode;

@property(nonatomic,strong) NSString *phoneDeviceName;

@end
