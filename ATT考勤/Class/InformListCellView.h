//
//  InformListCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "InformListModel.h"

@interface InformListCellView : HTableViewCell

@property(nonatomic,strong) InformListModel *informListModel;

@property(nonatomic,assign) NSInteger index;

@end
