//
//  DailyDetailsCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DailyDetailsCellView.h"

@implementation DailyDetailsCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)h_bindViewModel{
}

#pragma mark dataload
-(void)setDailyDetailsModel:(DailyDetailsModel *)dailyDetailsModel{
    if (!dailyDetailsModel) {
        return;
    }
    _dailyDetailsModel = dailyDetailsModel;
}

#pragma mark lazyload


@end
