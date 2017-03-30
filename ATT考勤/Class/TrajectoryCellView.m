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



@property(nonatomic,strong) UILabel *num;

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
        make.left.equalTo([self h_w:103]);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake([self h_w:1], [self h_w:110]));
    }];
    
    [self.cir1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.line);
        make.centerY.equalTo(weakSelf.year);
        make.size.equalTo(CGSizeMake([self h_w:10], [self h_w:10]));
    }];
    
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.cir1);
        make.centerX.equalTo(weakSelf.cir1);
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
    [self addSubview:self.num];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setTrajectoryModel:(TrajectoryModel *)trajectoryModel{
    if (!trajectoryModel) {
        return;
    }
    _trajectoryModel = trajectoryModel;
    self.year.text = trajectoryModel.cardDate;
    self.time1.text = trajectoryModel.cardTime;
    self.content1.text =[NSString stringWithFormat:@"位置:%@",trajectoryModel.locAddress];
    self.longitude1.text =[NSString stringWithFormat:@"经度:%@",trajectoryModel.locLongitude];
    self.latitude1.text =[NSString stringWithFormat:@"纬度:%@",trajectoryModel.locLatitude] ;
    
    
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
        ViewRadius(_cir1, [self h_w:5]);
    }
    return _cir1;
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
        _time1.text = @"";
        _time1.font = H14;
        _time1.textColor = MAIN_PAN_2;
    }
    return _time1;
}

-(UILabel *)num{
    if (!_num) {
        _num = [[UILabel alloc] init];
        _num.text = @"";
        _num.font = H10;
        _num.textColor = white_color;
    }
    return _num;
}


-(UILabel *)content1{
    if (!_content1) {
        _content1 = [[UILabel alloc] init];
        _content1.text = @"";
        _content1.font = H14;
        _content1.textColor = MAIN_PAN_2;
    }
    return _content1;
}



-(UILabel *)longitude1{
    if (!_longitude1) {
        _longitude1 = [[UILabel alloc] init];
        _longitude1.text = @"";
        _longitude1.font = H14;
        _longitude1.textColor = MAIN_PAN_2;
    }
    return _longitude1;
}


-(UILabel *)latitude1{
    if (!_latitude1) {
        _latitude1 = [[UILabel alloc] init];
        _latitude1.text = @"";
        _latitude1.font = H14;
        _latitude1.textColor = MAIN_PAN_2;
    }
    return _latitude1;
}





@end
