//
//  TeamAttendanceCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "TeamAttendanceModel.h"

@interface TeamAttendanceCellView : HTableViewCell

@property(nonatomic,strong) TeamAttendanceModel *teamAttendanceModel;

@end
