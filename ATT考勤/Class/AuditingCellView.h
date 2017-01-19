//
//  AuditingCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "AuditingModel.h"

@interface AuditingCellView : HTableViewCell

@property(nonatomic,strong) AuditingModel *auditingModel;

@end
