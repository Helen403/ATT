//
//  ChangeNameViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/2/28.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ChangeNameViewModel : HViewModel

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) NSString *userNickName;

@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) RACSubject *failSubject;

@end
