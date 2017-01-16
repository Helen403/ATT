//
//  CountCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/12.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "CountModel.h"

@interface CountCellView : HTableViewCell

@property(nonatomic,strong) CountModel *countModel;

@end
