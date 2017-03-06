//
//  ShiftCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "ShiftModel.h"


@interface ShiftCellView : HTableViewCell

@property(nonatomic,strong) ShiftModel *shiftModel;

@end
