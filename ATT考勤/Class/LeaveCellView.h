//
//  LeaveCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "LeaveModel.h"

@interface LeaveCellView : HTableViewCell

@property(nonatomic,strong) LeaveModel *leaveModel;

@end
