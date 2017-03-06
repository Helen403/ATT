//
//  GoOutCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "GoOutModel.h"

@interface GoOutCellView : HTableViewCell

@property(nonatomic,strong) GoOutModel *goOutModel;

@end
