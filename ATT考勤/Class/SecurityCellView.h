//
//  SecurityCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "SecurityModel.h"
@interface SecurityCellView : HTableViewCell

@property(nonatomic,strong) SecurityModel *securityModel;

@end
