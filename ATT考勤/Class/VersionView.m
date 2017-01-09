//
//  VersionView.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "VersionView.h"
#import "VersionViewModel.h"

@interface VersionView()

@property(nonatomic,strong) VersionViewModel *versionViewModel;

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIImageView *checkImg;

@property(nonatomic,strong) UILabel *checkText;

@property(nonatomic,strong) UILabel *number;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIImageView *introduceImg;

@property(nonatomic,strong) UILabel *introduceText;

@property(nonatomic,strong) UIView *line3;

@end

@implementation VersionView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.versionViewModel = (VersionViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo([self h_w:40]);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.icon.mas_bottom).offset([self h_w:15]);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.title.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.checkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1.mas_bottom).offset([self h_w:10]);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.checkText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.checkImg);
        make.left.equalTo(weakSelf.checkImg.mas_right).offset([self h_w:10]);
    }];
    
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.checkImg);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.checkImg.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.introduceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line2.mas_bottom).offset([self h_w:10]);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.introduceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.introduceImg);
        make.left.equalTo(weakSelf.introduceImg.mas_right).offset([self h_w:10]);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.introduceImg.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
  
    [self addSubview:self.icon];
    [self addSubview:self.title];
    [self addSubview:self.line1];
    [self addSubview:self.checkImg];
    [self addSubview:self.checkText];
    [self addSubview:self.number];
    [self addSubview:self.line2];
    [self addSubview:self.introduceImg];
    [self addSubview:self.introduceText];
    [self addSubview:self.line3];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(VersionViewModel *)versionViewModel{
    if (!_versionViewModel) {
        _versionViewModel = [[VersionViewModel alloc] init];
    }
    return _versionViewModel;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = ImageNamed(@"login_ATT_picture");
    }
    return _icon;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
        _title.text = @"版本号1.0.0";
    }
    return _title;
}


-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = BG_COLOR;
    }
    return _line1;
}

-(UIImageView *)checkImg{
    if (!_checkImg) {
        _checkImg = [[UIImageView alloc] init];
        _checkImg.image = ImageNamed(@"role_code_icon");
    }
    return _checkImg;
}


-(UILabel *)checkText{
    if (!_checkText) {
        _checkText = [[UILabel alloc] init];
        _checkText.font = H14;
        _checkText.textColor = MAIN_PAN_2;
        _checkText.text = @"检测更新";
    }
    return _checkText;
}

-(UILabel *)number{
    if (!_number) {
        _number = [[UILabel alloc] init];
        _number.font = H14;
        _number.textColor = MAIN_PAN_2;
        _number.text = @"新版本1.0.0";
    }
    return _number;
}


-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = BG_COLOR;
    }
    return _line2;
}


-(UIImageView *)introduceImg{
    if (!_introduceImg) {
        _introduceImg = [[UIImageView alloc] init];
        _introduceImg.image = ImageNamed(@"role_code_icon");
    }
    return _introduceImg;
}

-(UILabel *)introduceText{
    
    if (!_introduceText) {
        _introduceText = [[UILabel alloc] init];
        _introduceText.font = H14;
        _introduceText.textColor = MAIN_PAN_2;
        _introduceText.text = @"新功能介绍";
    }
    return _introduceText;
}

-(UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = BG_COLOR;
    }
    return _line3;
}



@end
