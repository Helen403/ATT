//
//  TeamCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "TeamModel.h"


@interface TeamCellView : HTableViewCell

@property(nonatomic,strong) TeamModel *teamModel;

@end
