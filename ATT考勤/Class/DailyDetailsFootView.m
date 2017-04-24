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

@property(nonatomic,strong) UIView *line;

@end

@implementation DailyDetailsFootView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.goOutWorkHours mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:20]);
        make.top.equalTo([self h_w:10]);
    }];
    [self.overWorkHours mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goOutWorkHours);
        make.top.equalTo(weakSelf.goOutWorkHours.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.workHours mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goOutWorkHours);
        make.top.equalTo(weakSelf.overWorkHours.mas_bottom).offset([self h_w:10]);
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
    [self addSubview:self.goOutWorkHours];
    [self addSubview:self.overWorkHours];
    [self addSubview:self.workHours];
    [self addSubview:self.line];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload



#pragma mark dataload
-(void)setDailyDetailsModel:(DailyDetailsModel *)dailyDetailsModel{
    if (!dailyDetailsModel) {
        return;
    }
    _dailyDetailsModel = dailyDetailsModel;
    self.goOutWorkHours.text = [NSString stringWithFormat:@"当天请假时间:%.2f小时",dailyDetailsModel.goOutWorkHours.floatValue];
    self.overWorkHours.text = [NSString stringWithFormat:@"当天外出时间:%.2f小时",dailyDetailsModel.overWorkHours.floatValue];
    CGFloat work = dailyDetailsModel.workHours.floatValue;
    self.workHours.text = [NSString stringWithFormat:@"当天工作时间:%.2f小时",work];
}


#pragma mark lazydata
-(UILabel *)goOutWorkHours{
    if (!_goOutWorkHours) {
        _goOutWorkHours = [[UILabel alloc] init];
        _goOutWorkHours.text = @"当天请假时间:0.00小时";
        _goOutWorkHours.font = H14;
        _goOutWorkHours.textColor = MAIN_PAN_2;
    }
    return _goOutWorkHours;
}
-(UILabel *)overWorkHours{
    if (!_overWorkHours) {
        _overWorkHours = [[UILabel alloc] init];
        _overWorkHours.text = @"当天外出时间:0.00小时";
        _overWorkHours.font = H14;
        _overWorkHours.textColor = MAIN_PAN_2;
    }
    return _overWorkHours;
}
-(UILabel *)workHours{
    if (!_workHours) {
        _workHours = [[UILabel alloc] init];
        _workHours.text = @"当天工作时间:0.00小时";
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
