//
//  MySchedulieCellView.h
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "MySchedulieModel.h"

@interface MySchedulieCellView : HTableViewCell

@property(nonatomic,strong) MySchedulieModel *mySchedulieModel;

@end
