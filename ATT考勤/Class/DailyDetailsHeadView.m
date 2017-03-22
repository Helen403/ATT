//
//  DailyDetailsHeadView.m
//  ATT考勤
//
//  Created by Helen on 17/3/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DailyDetailsHeadView.h"

@interface DailyDetailsHeadView()

@property(nonatomic,strong) UILabel *shift;

@property(nonatomic,strong) UILabel *count;

@property(nonatomic,strong) UIView *line;

@end

@implementation DailyDetailsHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = white_color;
        [self addSubview:self.shift];
        self.shift.frame = CGRectMake(SCREEN_WIDTH*0.07, 0, SCREEN_WIDTH, frame.size.height);

        [self addSubview:self.count];
        self.count.frame = CGRectMake(SCREEN_WIDTH/2+SCREEN_WIDTH*0.07, 0, SCREEN_WIDTH, frame.size.height);
        [self addSubview:self.line];
        self.line.frame = CGRectMake(0, frame.size.height-[self h_w:1], SCREEN_WIDTH, [self h_w:1]);
    }
    return self;
}

-(void)setDailyDetailsModel:(DailyDetailsModel *)dailyDetailsModel{
    if (!dailyDetailsModel) {
        return;
    }
     _dailyDetailsModel = dailyDetailsModel;
    self.shift.text = [NSString stringWithFormat:@"班次:%@",dailyDetailsModel.shiftName];
    self.count.text = [NSString stringWithFormat:@"打卡:%@次",dailyDetailsModel.signCount];
}

#pragma mark lazyload
-(UILabel *)shift{
    if (!_shift) {
        _shift = [[UILabel alloc] init];
        _shift.text = @"";
        _shift.font = H14;
        _shift.textColor = MAIN_PAN_2;
     
    }
    return _shift;
}

-(UILabel *)count{
    if (!_count) {
        _count = [[UILabel alloc] init];
        _count.text = @"";
        _count.font = H14;
        _count.textColor = MAIN_PAN_2;
    }
    return _count;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

@end
