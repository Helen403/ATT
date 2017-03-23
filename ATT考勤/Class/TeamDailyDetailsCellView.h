//
//  TeamDailyDetailsCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "TeamDailyDetailsModel.h"

@interface TeamDailyDetailsCellView : HTableViewCell

@property(nonatomic,strong) TeamDailyDetailsModel *teamDailyDetailsModel;

@property(nonatomic,assign) NSInteger index;

@end
