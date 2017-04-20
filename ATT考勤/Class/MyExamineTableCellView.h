//
//  MyExamineTableCellView.h
//  ATT考勤
//
//  Created by Helen on 16/12/28.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "MyExamineModel.h"

@interface MyExamineTableCellView : HTableViewCell

@property(nonatomic,strong) MyExamineModel *myExamineModel;

@property(nonatomic,strong) UILabel *hint;

@end
