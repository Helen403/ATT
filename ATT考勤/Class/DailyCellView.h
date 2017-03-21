//
//  DailyCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "DailyModel.h"

@interface DailyCellView : HTableViewCell

@property(nonatomic,strong) DailyModel *dailyModel;

@end
