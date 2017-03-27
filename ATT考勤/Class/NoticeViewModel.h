//
//  NoticeViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"
#import "AnnouncementModel.h"

@interface NoticeViewModel : HViewModel

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *userCode;

@property(nonatomic,strong) RACSubject *successSubject;



@property(nonatomic,strong) NSMutableArray *preArr;

@property(nonatomic,assign) NSInteger index;

@property(nonatomic,strong) AnnouncementModel *announcement;

@end
