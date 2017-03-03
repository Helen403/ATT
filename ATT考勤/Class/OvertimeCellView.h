//
//  OvertimeCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/3.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "OvertimeModel.h"

@interface OvertimeCellView : HTableViewCell

@property(nonatomic,strong) OvertimeModel *overtimeModel;

@end
