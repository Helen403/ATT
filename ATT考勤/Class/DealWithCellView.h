//
//  DealWithCellView.h
//  ATT考勤
//
//  Created by Helen on 16/12/29.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "DealWithModel.h"

@interface DealWithCellView : HTableViewCell

@property(nonatomic,strong) DealWithModel *dealWithModel;

@end
