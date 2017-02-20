//
//  ScanCodeViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/2/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface ScanCodeViewModel : HViewModel

@property(nonatomic,strong) RACSubject *addclickSubject;

@property (nonatomic, strong) RACCommand *sendclickCommand;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) NSString *inviteCode;

@property(nonatomic,strong) RACSubject *showClickSubject;

@property(nonatomic,strong) NSMutableArray *arr;

@property (nonatomic, strong) RACCommand *addTeamCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *deptCode;


@end
