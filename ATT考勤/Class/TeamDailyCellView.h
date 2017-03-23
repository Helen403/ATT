//
//  TeamDailyCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "TeamDailyModel.h"

@interface TeamDailyCellView : HTableViewCell

@property(nonatomic,strong) TeamDailyModel *teamDailyModel;

@end
