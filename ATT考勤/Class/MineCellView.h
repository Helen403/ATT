//
//  MineCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "MineModel.h"
#import "UserModel.h"

@interface MineCellView : HTableViewCell

@property(nonatomic,strong) MineModel *mineModel;

@property(nonatomic,strong) UserModel *userModel;

@property(nonatomic,assign) NSInteger index;

@end
