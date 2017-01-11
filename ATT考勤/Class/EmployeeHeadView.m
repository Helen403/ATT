//
//  EmployeeHeadView.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "EmployeeHeadView.h"

@interface EmployeeHeadView()

@property(nonatomic,strong) UIImageView *bgImg;

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *autograph;

@property(nonatomic,strong) UIImageView *star;

@end

@implementation EmployeeHeadView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.bottom.equalTo(-[self h_w:15]);
        make.size.equalTo(CGSizeMake([self h_w:60], [self h_w:60]));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.icon.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.icon.mas_top).offset([self h_w:10]);
    }];
    
    [self.autograph mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.icon.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.name.mas_bottom).offset([self h_w:6]);
    }];
    
    [self.star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.icon);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.bgImg];
    [self addSubview:self.icon];
    [self addSubview:self.name];
    [self addSubview:self.autograph];
    [self addSubview:self.star];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(UIImageView *)bgImg{
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc] init];
        _bgImg.backgroundColor = MAIN_ORANGER;
    }
    return _bgImg;
}

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
        _name.text = @"黄慧";
        _name.font = H20;
        _name.textColor = white_color;
    }
    return _name;
}

-(UILabel *)autograph{
    if (!_autograph) {
        _autograph = [[UILabel alloc] init];
        _autograph.text = @"树欲静而风不止";
        _autograph.font = H14;
        _autograph.textColor = white_color;
    }
    return _autograph;
}

-(UIImageView *)star{
    if (!_star) {
        _star = [[UIImageView alloc] init];
        _star.image = ImageNamed(@"role_code_icon");
    }
    return _star;
}

@end
