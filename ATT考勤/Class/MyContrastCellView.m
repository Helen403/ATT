//
//  MyContrastCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyContrastCellView.h"




@interface MyContrastCellView()

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIView *line3;

@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UILabel *current;

@end

@implementation MyContrastCellView

#pragma mark system
-(void)updateConstraints{
    
    
    CGFloat length = arc4random_uniform(SCREEN_WIDTH*0.8);
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:35]);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake([self h_w:2],[self h_w:40]));
        
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake([self h_w:3],[self h_w:2] ));
        make.left.equalTo([self h_w:32]);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line2.mas_right).offset(0);
        make.centerY.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(length,[self h_w:36]));
    }];
    
    [self.current mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.line.mas_right).offset([self h_w:10]);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.line];
    [self addSubview:self.line1];
    [self addSubview:self.line2];
    [self addSubview:self.line3];
    [self addSubview:self.current];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload

-(void)setMyContrastModel:(MyContrastModel *)myContrastModel{
    if (!myContrastModel) {
        return;
    }
    _myContrastModel = myContrastModel;
    self.title.text = myContrastModel.title;
    self.current.text = myContrastModel.current;}


#pragma mark lazyload
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"1";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = randomColorA;
    }
    return _line;
}

-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_ORANGER;
    }
    return _line1;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_ORANGER;
    }
    return _line2;
}

-(UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = MAIN_ORANGER;
    }
    return _line3;
}

-(UILabel *)current{
    if (!_current) {
        _current = [[UILabel alloc] init];
        _current.text = @"7.8小时";
        _current.font = H14;
        _current.textColor = MAIN_ORANGER;
    }
    return _current;
}
@end
