//
//  StatisticsCellViewTableViewCell.h
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//


#import "StatisticsModel.h"
#import "HTableViewCell.h"


@interface StatisticsCellView : HTableViewCell

@property(nonatomic,strong) StatisticsModel *statisticsModel;

@end
