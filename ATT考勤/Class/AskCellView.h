//
//  AskCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "AskModel.h"

@interface AskCellView : HTableViewCell

@property(nonatomic,strong) AskModel *askModel;

@end
