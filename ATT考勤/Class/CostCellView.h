//
//  CostCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "CostModel.h"
#import "CostWorkModel.h"

@interface CostCellView : HTableViewCell

@property(nonatomic,strong) CostModel *costModel;

@property(nonatomic,strong) CostWorkModel *costWorkModel;

@end
