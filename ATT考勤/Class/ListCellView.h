//
//  ListCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/12.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "ListModel.h"

@interface ListCellView : HTableViewCell

@property(nonatomic,strong) ListModel *listModel;

@end
