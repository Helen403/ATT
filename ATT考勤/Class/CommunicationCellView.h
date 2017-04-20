//
//  CommunicationCellView.h
//  ATT考勤
//
//  Created by Helen on 17/4/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "CommunicationModel.h"

@interface CommunicationCellView : HTableViewCell

@property(nonatomic,strong) CommunicationModel *communicationModel;

@end
