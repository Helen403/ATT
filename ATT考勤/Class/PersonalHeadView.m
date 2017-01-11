//
//  PersonalHeadView.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "PersonalHeadView.h"

@interface PersonalHeadView()

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *department;

@property(nonatomic,strong) UILabel *year;

@property(nonatomic,strong) UILabel *month;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UILabel *status;

@property(nonatomic,strong) UILabel *day;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UILabel *overTimeTitle;

@property(nonatomic,strong) UILabel *overTime;

@end

@implementation PersonalHeadView

#pragma mark system
-(void)updateConstraints{
    
    CGFloat length = SCREEN_WIDTH/3.f;
    
    WS(weakSelf);
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([self h_w:10]);
        make.left.equalTo([self h_w:10]);
        make.size.equalTo(CGSizeMake([self h_w:50], [self h_w:50]));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.icon.mas_right).offset([self h_w:10]);
        make.top.equalTo([self h_w:15]);
    }];
    
    [self.department mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.icon.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.name.mas_bottom).offset([self h_w:6]);
    }];
    
    [self.month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(-length*0.5-length*0.5);
        make.bottom.equalTo(-[self h_w:10]);
    }];
    
    [self.year mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(-length*0.5-length*0.5);
        make.bottom.equalTo(weakSelf.month.mas_top).offset(-[self h_w:10]);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-[self h_w:10]);
        make.size.equalTo(CGSizeMake([self h_w:1], [self h_w:55]));
        make.left.equalTo(length);
    }];
    
    [self.day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(-[self h_w:10]);
    }];
    
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.day.mas_top).offset(-[self h_w:10]);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-[self h_w:10]);
        make.size.equalTo(CGSizeMake([self h_w:1], [self h_w:55]));
        make.left.equalTo(2*length);
    }];
    
    [self.overTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.day.mas_top).offset(-[self h_w:10]);
        make.centerX.equalTo(length);
    }];
    
    [self.overTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(length);
        make.bottom.equalTo(-[self h_w:10]);
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.icon];
    [self addSubview:self.name];
    [self addSubview:self.department];
    [self addSubview:self.year];
    [self addSubview:self.month];
    [self addSubview:self.line1];
    [self addSubview:self.status];
    [self addSubview:self.day];
    [self addSubview:self.line2];
    [self addSubview:self.overTimeTitle];
    [self addSubview:self.overTime];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = ImageNamed(@"information_nickname_picture");
    }
    return _icon;
}


-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"大卫";
        _name.font = H18;
        _name.textColor = white_color;
    }
    return _name;
}


-(UILabel *)department{
    if (!_department) {
        _department = [[UILabel alloc] init];
        _department.text = @"国际市场部 主管";
        _department.font = H14;
        _department.textColor = white_color;
    }
    return _department;
}

-(UILabel *)year{
    if (!_year) {
        _year = [[UILabel alloc] init];
        _year.text = @"2016年";
        _year.font = H14;
        _year.textColor = white_color;
    }
    return _year;
}

-(UILabel *)month{
    if (!_month) {
        _month = [[UILabel alloc] init];
        _month.text = @"12月";
        _month.font = H18;
        _month.textColor = white_color;
    }
    return _month;
}

-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = BG_COLOR;
    }
    return _line1;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = BG_COLOR;
    }
    return _line2;
}

-(UILabel *)status{
    if (!_status) {
        _status = [[UILabel alloc] init];
        _status.text = @"正常考勤";
        _status.font = H14;
        _status.textColor = white_color;
    }
    return _status;
}

-(UILabel *)day{
    if (!_day) {
        _day = [[UILabel alloc] init];
        _day.text = @"25天";
        _day.font = H18;
        _day.textColor = white_color;
    }
    return _day;
}

-(UILabel *)overTimeTitle{
    if (!_overTimeTitle) {
        _overTimeTitle = [[UILabel alloc] init];
        _overTimeTitle.text = @"加班";
        _overTimeTitle.font = H14;
        _overTimeTitle.textColor = white_color;
    }
    return _overTimeTitle;
}

-(UILabel *)overTime{
    if (!_overTime) {
        _overTime = [[UILabel alloc] init];
        _overTime.text = @"2次";
        _overTime.font = H18;
        _overTime.textColor = white_color;
    }
    return _overTime;
}



@end
