//
//  MyMsgCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "MyMsgModel.h"

@interface MyMsgCellView : HTableViewCell

@property(nonatomic,strong) MyMsgModel *myMsgModel;

@end
