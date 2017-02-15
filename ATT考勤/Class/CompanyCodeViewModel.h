//
//  CompanyCodeViewModel.h
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@interface CompanyCodeViewModel : HViewModel

@property(nonatomic,strong) RACSubject *addclickSubject;

@property (nonatomic, strong) RACCommand *sendclickCommand;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) NSString *companyCode;

@property (nonatomic, strong) RACCommand *sendCommand;

@end
