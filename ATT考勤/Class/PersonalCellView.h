//
//  PersonalCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "PersonalModel.h"

@interface PersonalCellView : HTableViewCell

@property(nonatomic,strong) PersonalModel *personalModel;

@end
