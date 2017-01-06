//
//  FunctionCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "FunctionCellView.h"


@interface FunctionCellView()

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *version;

@property(nonatomic,strong) UILabel *content;

@property(nonatomic,strong) UILabel *more;

@property(nonatomic,strong) UIView *line2;

@end


@implementation FunctionCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake([self h_w:10], SCREEN_WIDTH));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([self h_w:10]);
        make.left.equalTo([self h_w:20]);
    }];
    
    [self.version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([self h_w:10]);
        make.right.equalTo(-[self h_w:20]);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.time.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.time);
    }];
    
    [self.more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.content.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.time);
    }];
 
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.size.equalTo(CGSizeMake([self h_w:10], SCREEN_WIDTH));
    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
   
    self.backgroundColor = BG_COLOR;
    
    
    [self addSubview:self.line1];
    [self addSubview:self.time];
    [self addSubview:self.version];
    [self addSubview:self.content];
    [self addSubview:self.more];
    [self addSubview:self.line2];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark dataload
-(void)setFunctionModel:(FunctionModel *)functionModel{
    if (!functionModel) {
        return;
    }
    _functionModel = functionModel;
    self.time.text = functionModel.time;
    self.version.text = functionModel.version;
    self.content.text = functionModel.content;
}


#pragma mark lazyload
-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = H14;
        _time.textColor = MAIN_PAN_2;
        _time.text = @"2016年12月25日";
    }
    return _time;
}

-(UILabel *)version{
    if (!_version) {
        _version = [[UILabel alloc] init];
        _version.font = H14;
        _version.textColor = MAIN_PAN_2;
        _version.text = @"系统版本1.00";
    }
    return _version;
}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.font = H14;
        _content.textColor = MAIN_PAN_2;
        _content.text = @"班次管理新增分组功能";
    }
    return _content;
}

-(UILabel *)more{
    if (!_more) {
        _more = [[UILabel alloc] init];
        _more.font = H14;
        _more.textColor = MAIN_ORANGER;
        _more.text = @"查看原文";
    }
    return _more;
}


-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = white_color;
    }
    return _line1;

}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = white_color;
    }
    return _line2;
    
}


@end
