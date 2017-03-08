//
//  MessageCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "MessageModel.h"

@interface MessageCellView : HTableViewCell

@property(nonatomic,strong) MessageModel *messageModel;

@property(nonatomic,assign) NSInteger index;


@property(nonatomic,strong) UISwitch *on;

@end
