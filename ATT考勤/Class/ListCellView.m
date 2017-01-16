//
//  ListCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/12.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ListCellView.h"

@interface ListCellView()

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *content;

@property(nonatomic,strong) UILabel *remark;


@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIView *line3;

@property(nonatomic,strong) UIView *line4;

@property(nonatomic,strong) UIView *line5;

@property(nonatomic,strong) UIView *line6;

@end

@implementation ListCellView

#pragma mark system
-(void)updateConstraints{
    
    
    CGFloat length = SCREEN_WIDTH/3.f;
    WS(weakSelf);
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake([self h_w:1], [self h_w:40]));
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(-length*0.5);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake([self h_w:1], [self h_w:40]));
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(length*0.5);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake([self h_w:1], [self h_w:40]));
    }];
    
    
    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.size.equalTo(CGSizeMake([self h_w:1], [self h_w:40]));
    }];
    
    [self.line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.line6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(-length);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.remark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(length);
    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.line1];
    [self addSubview:self.line2];
    [self addSubview:self.line3];
    [self addSubview:self.line4];
    [self addSubview:self.line5];
     [self addSubview:self.line6];
    [self addSubview:self.time];
    [self addSubview:self.content];
    [self addSubview:self.remark];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setListModel:(ListModel *)listModel{
    if (!listModel) {
        return;
    }
    
    _listModel = listModel;
    self.time.text = listModel.time;
    self.content.text = listModel.content;
    self.remark.text = listModel.remark;
}


#pragma mark lazyload
-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line1;
}


-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line2;
}


-(UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line3;
}

-(UIView *)line4{
    if (!_line4) {
        _line4 = [[UIView alloc] init];
        _line4.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line4;
}


-(UIView *)line5{
    if (!_line5) {
        _line5 = [[UIView alloc] init];
        _line5.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line5;
}

-(UIView *)line6{
    if (!_line6) {
        _line6 = [[UIView alloc] init];
        _line6.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line6;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"2016年12月25日";
        _time.font = H14;
        _time.textColor = MAIN_PAN_2;
    }
    return _time;
}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.text = @"08:56-18:00";
        _content.font = H14;
        _content.textColor = MAIN_PAN_2;
    }
    return _content;
}

-(UILabel *)remark{
    if (!_remark) {
        _remark = [[UILabel alloc] init];
        _remark.text = @"正常签到";
        _remark.font = H14;
        _remark.textColor = MAIN_PAN_2;
    }
    return _remark;
}


@end
