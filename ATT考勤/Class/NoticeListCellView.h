//
//  NoticeListCellView.h
//  ATT考勤
//
//  Created by Helen on 17/3/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HTableViewCell.h"
#import "NoticeListModel.h"

@interface NoticeListCellView : HTableViewCell

@property(nonatomic,strong) NoticeListModel *noticeListModel;

@property(nonatomic,assign) NSInteger index;

@end
