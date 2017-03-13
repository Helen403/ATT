//
//  TimeCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "TimeModel.h"

@interface TimeCellView : HTableViewCell

@property(nonatomic,strong) TimeModel *timeModel;

@property(nonatomic,assign) NSInteger index;

@end
