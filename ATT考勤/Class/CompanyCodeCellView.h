//
//  CompanyCodeCellView.h
//  ATT考勤
//
//  Created by Helen on 17/2/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "TeamModel.h"

@interface CompanyCodeCellView : HTableViewCell

@property(nonatomic,strong) TeamModel *teamModel;

@end
