//
//  WeekCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "WeekModel.h"

@interface WeekCellView : HTableViewCell

@property(nonatomic,strong) WeekModel *weekModel;

@end
