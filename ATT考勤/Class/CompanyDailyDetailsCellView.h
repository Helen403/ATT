//
//  CompanyDailyDetailsCellView.h
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "CompanyDailyDetailsModel.h"

@interface CompanyDailyDetailsCellView : HTableViewCell

@property(nonatomic,strong) CompanyDailyDetailsModel *companyDailyDetailsModel;

@property(nonatomic,assign) NSInteger index;

@end
