//
//  ChoiceStaffCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "TeamListModel.h"

@interface ChoiceStaffCellView : HTableViewCell

@property(nonatomic,strong) TeamListModel *teamListModel;

@property(nonatomic,strong) UIColor *bgColor;

@end
