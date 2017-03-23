//
//  SignCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "SignModel.h"

@interface SignCellView : HTableViewCell

@property(nonatomic,strong) SignModel *signModel;

@property(nonatomic,assign) NSInteger index;

@end
