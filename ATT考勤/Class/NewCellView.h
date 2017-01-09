//
//  NewCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "NewsModel.h"

@interface NewCellView : HTableViewCell

@property(nonatomic,strong) NewsModel *newsModel;

@end
