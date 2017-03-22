//
//  WeekDetailsHeadView.m
//  ATT考勤
//
//  Created by Helen on 17/3/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "WeekDetailsHeadView.h"

@interface WeekDetailsHeadView()

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *workHours;

@property(nonatomic,strong) UIView *line;

@end

@implementation WeekDetailsHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = white_color;
        [self addSubview:self.time];
        self.time.frame = CGRectMake(SCREEN_WIDTH*0.07, 0, SCREEN_WIDTH, frame.size.height);
        
        [self addSubview:self.workHours];
        self.workHours.frame = CGRectMake(SCREEN_WIDTH/2+SCREEN_WIDTH*0.07, 0, SCREEN_WIDTH, frame.size.height);
        [self addSubview:self.line];
        self.line.frame = CGRectMake(0, frame.size.height-[self h_w:1], SCREEN_WIDTH, [self h_w:1]);
    }
    return self;
}

#pragma mark dataload
-(void)setWeekHours:(NSString *)weekHours{
    if (!weekHours) {
        return;
    }
    _weekHours = weekHours;
    NSString *head = [LSCoreToolCenter getFormatter:self.startDate];
    NSString *end =  [LSCoreToolCenter getFormatter:self.endDate];
    self.time.text = [NSString stringWithFormat:@"%@-%@",head,end];
    self.workHours.text = [NSString stringWithFormat:@"工作时间:%@分钟",weekHours];
}

#pragma mark lazydata
-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"";
        _time.font = H14;
        _time.textColor = MAIN_PAN_2;
    }
    return _time;
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

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

@end
