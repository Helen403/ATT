//
//  DailyDetailsFootView.m
//  ATT考勤
//
//  Created by Helen on 17/3/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DailyDetailsFootView.h"

@interface DailyDetailsFootView()

@property(nonatomic,strong) UILabel *goOutWorkHours;

@property(nonatomic,strong) UILabel *overWorkHours;

@property(nonatomic,strong) UILabel *workHours;

@end

@implementation DailyDetailsFootView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = white_color;
        [self addSubview:self.goOutWorkHours];
        self.goOutWorkHours.frame = CGRectMake(SCREEN_WIDTH*0.06, 0, SCREEN_WIDTH, [self h_w:30]);
        [self addSubview:self.overWorkHours];
        self.overWorkHours.frame = CGRectMake(SCREEN_WIDTH*0.06, [self h_w:30], SCREEN_WIDTH, [self h_w:30]);
        [self addSubview:self.workHours];
        self.workHours.frame = CGRectMake(SCREEN_WIDTH*0.06, [self h_w:30]*2, SCREEN_WIDTH, [self h_w:30]);
    }
    return self;
}

-(void)setDailyDetailsModel:(DailyDetailsModel *)dailyDetailsModel{
    if (!dailyDetailsModel) {
        return;
    }
    _dailyDetailsModel = dailyDetailsModel;
    self.goOutWorkHours.text = [NSString stringWithFormat:@"当天请假时间:%@分钟",dailyDetailsModel.goOutWorkHours];
    self.overWorkHours.text = [NSString stringWithFormat:@"当天外出时间:%@分钟",dailyDetailsModel.overWorkHours];
    CGFloat work = dailyDetailsModel.workHours.floatValue;
    self.workHours.text = [NSString stringWithFormat:@"当天工作时间:%.2f分钟",work];
}


#pragma mark lazydata
-(UILabel *)goOutWorkHours{
    if (!_goOutWorkHours) {
        _goOutWorkHours = [[UILabel alloc] init];
        _goOutWorkHours.text = @"";
        _goOutWorkHours.font = H14;
        _goOutWorkHours.textColor = MAIN_PAN_2;
    }
    return _goOutWorkHours;
}
-(UILabel *)overWorkHours{
    if (!_overWorkHours) {
        _overWorkHours = [[UILabel alloc] init];
        _overWorkHours.text = @"";
        _overWorkHours.font = H14;
        _overWorkHours.textColor = MAIN_PAN_2;
    }
    return _overWorkHours;
}
-(UILabel *)workHours{
    if (!_workHours) {
        _workHours = [[UILabel alloc] init];
        _workHours.text = @"";
        _workHours.font = H14;
        _workHours.textColor = MAIN_PAN_2;
    }
    return _workHours;
}

@end
