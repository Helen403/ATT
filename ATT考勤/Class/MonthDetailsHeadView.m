//
//  MonthDetailsHeadView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MonthDetailsHeadView.h"

@interface MonthDetailsHeadView()

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *problem;

@property(nonatomic,strong) UIView *line;

@end

@implementation MonthDetailsHeadView

#pragma mark system

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.centerY.equalTo(weakSelf);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
    }];
    [self.problem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:30]);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:1]);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.time];
    [self addSubview:self.title];
    [self addSubview:self.problem];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"日期";
        _time.font = H14;
        _time.textColor = MAIN_PAN_2;
    }
    return _time;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"打卡时间";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UILabel *)problem{
    if (!_problem) {
        _problem = [[UILabel alloc] init];
        _problem.text = @"处理";
        _problem.font = H14;
        _problem.textColor = MAIN_PAN_2;
    }
    return _problem;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

@end
