//
//  MyContrastCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "MyContrastModel.h"

@interface MyContrastCellView : HTableViewCell

@property(nonatomic,strong) MyContrastModel *myContrastModel;

@property(nonatomic,strong) NSString *average;

@end
