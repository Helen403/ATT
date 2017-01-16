//
//  TrajectoryCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/12.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TrajectoryCellView.h"

@interface TrajectoryCellView()

@property(nonatomic,strong) UILabel *year;

@property(nonatomic,strong) UIView *cir1;

@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UILabel *time1;

@property(nonatomic,strong) UILabel *content1;

@property(nonatomic,strong) UILabel *longitude1;

@property(nonatomic,strong) UILabel *latitude1;

@property(nonatomic,strong) UIView *cir2;

@property(nonatomic,strong) UILabel *time2;

@property(nonatomic,strong) UILabel *content2;

@property(nonatomic,strong) UILabel *longitude2;

@property(nonatomic,strong) UILabel *latitude2;

@end

@implementation TrajectoryCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.year mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:10]);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.year.mas_right).offset([self h_w:23]);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake([self h_w:1], SCREEN_WIDTH));
    }];
    
    [self.cir1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.line);
        make.top.equalTo([self h_w:10]);
        make.size.equalTo(CGSizeMake([self h_w:6], [self h_w:6]));
    }];
    
    [self.time1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line.mas_right).offset([self h_w:10]);
        make.top.equalTo([self h_w:10]);
    }];
    
    [self.content1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.time1.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.longitude1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.content1.mas_bottom).offset([self h_w:10]);
        
    }];
    
    [self.latitude1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.longitude1.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.cir2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.line);
        make.top.equalTo(weakSelf.latitude1.mas_bottom).offset([self h_w:10]);
        make.size.equalTo(CGSizeMake([self h_w:6], [self h_w:6]));
    }];
    
    [self.time2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.latitude1.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.content2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.time2.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.longitude2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.content2.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.latitude2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.longitude2.mas_bottom).offset([self h_w:10]);
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    
    [self addSubview:self.year];
    [self addSubview:self.cir1];
    [self addSubview:self.line];
    [self addSubview:self.time1];
    [self addSubview:self.content1];
    [self addSubview:self.longitude1];
    [self addSubview:self.latitude1];
    [self addSubview:self.cir2];
    [self addSubview:self.time2];
    [self addSubview:self.content2];
    [self addSubview:self.longitude2];
    [self addSubview:self.latitude2];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setTrajectoryModel:(TrajectoryModel *)trajectoryModel{
    if (!trajectoryModel) {
        return;
    }
    _trajectoryModel = trajectoryModel;
    self.year.text = trajectoryModel.year;
    self.time1.text = trajectoryModel.time1;
    self.content1.text = trajectoryModel.content1;
    self.longitude1.text = trajectoryModel.longitude1;
    self.latitude1.text = trajectoryModel.latitude1;
    self.time2.text = trajectoryModel.time2;
    self.content2.text = trajectoryModel.content2;
    self.longitude2.text = trajectoryModel.longitude2;
    self.latitude2.text = trajectoryModel.latitude2;
}

#pragma mark lazyload
-(UILabel *)year{
    if (!_year) {
        _year = [[UILabel alloc] init];
        _year.text = @"2016年12月25日";
        _year.font = H14;
        _year.textColor = MAIN_PAN_2;
    }
    return _year;
}

-(UIView *)cir1{
    if (!_cir1) {
        _cir1 = [[UIView alloc] init];
        _cir1.backgroundColor = MAIN_ORANGER;
        ViewRadius(_cir1, [self h_w:3]);
    }
    return _cir1;
}

-(UIView *)cir2{
    if (!_cir2) {
        _cir2 = [[UIView alloc] init];
        _cir2.backgroundColor = MAIN_ORANGER;
        ViewRadius(_cir2, [self h_w:3]);
    }
    return _cir2;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_ORANGER;
    }
    return _line;
}

-(UILabel *)time1{
    if (!_time1) {
        _time1 = [[UILabel alloc] init];
        _time1.text = @"反馈类型";
        _time1.font = H14;
        _time1.textColor = MAIN_PAN_2;
    }
    return _time1;
}


-(UILabel *)time2{
    if (!_time2) {
        _time2 = [[UILabel alloc] init];
        _time2.text = @"反馈类型";
        _time2.font = H14;
        _time2.textColor = MAIN_PAN_2;
    }
    return _time2;
}

-(UILabel *)content1{
    if (!_content1) {
        _content1 = [[UILabel alloc] init];
        _content1.text = @"反馈类型";
        _content1.font = H14;
        _content1.textColor = MAIN_PAN_2;
    }
    return _content1;
}

-(UILabel *)content2{
    if (!_content2) {
        _content2 = [[UILabel alloc] init];
        _content2.text = @"反馈类型";
        _content2.font = H14;
        _content2.textColor = MAIN_PAN_2;
    }
    return _content2;
}

-(UILabel *)longitude1{
    if (!_longitude1) {
        _longitude1 = [[UILabel alloc] init];
        _longitude1.text = @"反馈类型";
        _longitude1.font = H14;
        _longitude1.textColor = MAIN_PAN_2;
    }
    return _longitude1;
}

-(UILabel *)longitude2{
    if (!_longitude2) {
        _longitude2 = [[UILabel alloc] init];
        _longitude2.text = @"反馈类型";
        _longitude2.font = H14;
        _longitude2.textColor = MAIN_PAN_2;
    }
    return _longitude2;
}

-(UILabel *)latitude1{
    if (!_latitude1) {
        _latitude1 = [[UILabel alloc] init];
        _latitude1.text = @"反馈类型";
        _latitude1.font = H14;
        _latitude1.textColor = MAIN_PAN_2;
    }
    return _latitude1;
}

-(UILabel *)latitude2{
    if (!_latitude2) {
        _latitude2 = [[UILabel alloc] init];
        _latitude2.text = @"反馈类型";
        _latitude2.font = H14;
        _latitude2.textColor = MAIN_PAN_2;
    }
    return _latitude2;
}


@end
