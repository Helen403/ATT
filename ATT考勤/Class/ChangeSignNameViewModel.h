//
//  ChangeSignNameViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ChangeSignNameViewModel : HViewModel

@property(nonatomic,strong) NSString *userSignName;


@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *userCode;



@property(nonatomic,strong) RACSubject *successSubject;

@property(nonatomic,strong) RACSubject *failSubject;

@end
