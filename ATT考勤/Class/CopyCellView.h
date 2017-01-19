//
//  CopyCellView.h
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "CopyToMeModel.h"

@interface CopyCellView : HTableViewCell

@property(nonatomic,strong) CopyToMeModel *toMeModel;

@end
