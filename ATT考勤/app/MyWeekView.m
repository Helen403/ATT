//
//  MyWeekView.m
//  ATT考勤
//
//  Created by Helen on 17/3/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyWeekView.h"

@interface MyWeekView()

@property(nonatomic,strong) UILabel *week1;

@property(nonatomic,strong) UILabel *week2;
@property(nonatomic,strong) UILabel *week3;
@property(nonatomic,strong) UILabel *week4;
@property(nonatomic,strong) UILabel *week5;
@property(nonatomic,strong) UILabel *week6;
@property(nonatomic,strong) UILabel *week7;


@end

@implementation MyWeekView

#pragma mark system


-(void)updateConstraints{
    
    WS(weakSelf);
    [self.week1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/7.f, [self h_w:30]));
    }];
    [self.week2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.week1.mas_right).offset(0);
        make.top.equalTo(weakSelf.week1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/7.f, [self h_w:30]));
    }];
    [self.week3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.week2.mas_right).offset(0);
        make.top.equalTo(weakSelf.week1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/7.f, [self h_w:30]));
    }];
    [self.week4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.week3.mas_right).offset(0);
        make.top.equalTo(weakSelf.week1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/7.f, [self h_w:30]));
    }];
    [self.week5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.week4.mas_right).offset(0);
        make.top.equalTo(weakSelf.week1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/7.f, [self h_w:30]));
    }];
    [self.week6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.week5.mas_right).offset(0);
        make.top.equalTo(weakSelf.week1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/7.f, [self h_w:30]));
    }];
    [self.week7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.week6.mas_right).offset(0);
        make.top.equalTo(weakSelf.week1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH/7.f, [self h_w:30]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.week1];
    [self addSubview:self.week2];
    [self addSubview:self.week3];
    [self addSubview:self.week4];
    [self addSubview:self.week5];
    [self addSubview:self.week6];
    [self addSubview:self.week7];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(UILabel *)week1{
    if (!_week1) {
        _week1 = [[UILabel alloc] init];
        _week1.text = @"周日";
        _week1.font = H14;
        _week1.textColor = MAIN_ORANGER;
        _week1.textAlignment = NSTextAlignmentCenter;
    }
    return _week1;
}
-(UILabel *)week2{
    if (!_week2) {
        _week2 = [[UILabel alloc] init];
        _week2.text = @"周一";
        _week2.font = H14;
        _week2.textColor = MAIN_PAN_2;
        _week2.textAlignment = NSTextAlignmentCenter;
    }
    return _week2;
}
-(UILabel *)week3{
    if (!_week3) {
        _week3 = [[UILabel alloc] init];
        _week3.text = @"周二";
        _week3.font = H14;
        _week3.textColor = MAIN_PAN_2;
        _week3.textAlignment = NSTextAlignmentCenter;
    }
    return _week3;
}

-(UILabel *)week4{
    if (!_week4) {
        _week4 = [[UILabel alloc] init];
        _week4.text = @"周三";
        _week4.font = H14;
        _week4.textColor = MAIN_PAN_2;
        _week4.textAlignment = NSTextAlignmentCenter;
    }
    return _week4;
}

-(UILabel *)week5{
    if (!_week5) {
        _week5 = [[UILabel alloc] init];
        _week5.text = @"周四";
        _week5.font = H14;
        _week5.textColor = MAIN_PAN_2;
        _week5.textAlignment = NSTextAlignmentCenter;
    }
    return _week5;
}

-(UILabel *)week6{
    if (!_week6) {
        _week6 = [[UILabel alloc] init];
        _week6.text = @"周五";
        _week6.font = H14;
        _week6.textColor = MAIN_PAN_2;
        _week6.textAlignment = NSTextAlignmentCenter;
    }
    return _week6;
}
-(UILabel *)week7{
    if (!_week7) {
        _week7 = [[UILabel alloc] init];
        _week7.text = @"周六";
        _week7.font = H14;
        _week7.textColor = MAIN_ORANGER;
        _week7.textAlignment = NSTextAlignmentCenter;
    }
    return _week7;
}

@end
