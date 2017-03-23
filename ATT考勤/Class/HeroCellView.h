//
//  HeroCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "HeroModel.h"

@interface HeroCellView : HTableViewCell

@property(nonatomic,strong) HeroModel *heroModel;

@property(nonatomic,assign) NSInteger index;

@end
