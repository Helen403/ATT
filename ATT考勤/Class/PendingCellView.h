//
//  PendingCellView.h
//  ATT考勤
//
//  Created by Helen on 16/12/28.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "FlowStepChecksModel.h"
@interface PendingCellView : HTableViewCell

@property(nonatomic,strong) FlowStepChecksModel *flowStepChecksModel;

@end
