//
//  FeedbackCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/13.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "FeedbackModel.h"

@interface FeedbackCellView : HTableViewCell

@property(nonatomic,strong) FeedbackModel *feedbackModel;

@end
