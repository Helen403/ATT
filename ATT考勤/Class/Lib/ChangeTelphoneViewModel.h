//
//  ChangeTelphoneViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/2/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ChangeTelphoneViewModel : HViewModel

@property (nonatomic, strong) RACCommand *sendclickCommand;

@property(nonatomic,strong) RACSubject *telphoneBackFailSubject;

@property(nonatomic,strong) NSString *telphone;

@property(nonatomic,strong) RACSubject *SMSbackSubject;

@property(nonatomic,strong) RACCommand *changeTelphoneCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@end
