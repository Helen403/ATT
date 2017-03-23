//
//  TeamRedBlackCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "TeamRedBlackModel.h"

@interface TeamRedBlackCellView : HTableViewCell

@property(nonatomic,strong) TeamRedBlackModel *teamRedBlackModel;

@property(nonatomic,assign) NSInteger index;

@end
