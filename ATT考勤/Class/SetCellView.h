//
//  SetCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "SetModel.h"

@interface SetCellView : HTableViewCell

@property(nonatomic,strong) SetModel *setModel;

-(void)setImgHidden:(Boolean)flag;

@end
