//
//  FunctionCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "FunctionModel.h"

@interface FunctionCellView : HTableViewCell

@property(nonatomic,strong) FunctionModel *functionModel;

@end
