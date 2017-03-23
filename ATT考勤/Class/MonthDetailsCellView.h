//
//  MonthDetailsCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "MonthDetailsModel.h"

@interface MonthDetailsCellView : HTableViewCell
@property(nonatomic,strong) MonthDetailsModel *monthDetailsModel;

@property(nonatomic,assign) NSInteger index;
@end
