//
//  CopyDetailsViewModel.h
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HViewModel.h"
#import "CopyDetailsModel.h"

@interface CopyDetailsViewModel : HViewModel

@property(nonatomic,strong) RACCommand *refreshDataCommand;

@property(nonatomic,strong) NSString *companyCode;

@property(nonatomic,strong) NSString *applyType;

@property(nonatomic,strong) NSString *applyLsh;


@property(nonatomic,strong) RACSubject *tableViewSubject;

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) NSMutableArray *lateArr;

@property(nonatomic,assign) NSInteger indexTmp;

@property(nonatomic,strong) CopyDetailsModel *toDetailModel;

@end
