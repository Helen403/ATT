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

@property(nonatomic,strong) UILabel *img;

@property(nonatomic,strong) UIView *view;

@property(nonatomic,strong) UIView *titleView;

@property(nonatomic,strong) UILabel *titleViewText;

@end

@implementation EmployeeHeadView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:20]);
    }];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.bottom.equalTo(-[self h_w:15]);
        make.size.equalTo(CGSizeMake([self h_w:60], [self h_w:60]));
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view);
        make.centerX.equalTo(weakSelf.view);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.view.mas_top).offset([self h_w:10]);
    }];
    
    [self.autograph mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.name.mas_bottom).offset([self h_w:6]);
    }];
    
    [self.star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgImg.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:20]));
    }];
    
    [self.titleViewText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.titleView);
        make.left.equalTo([self h_w:10]);
    }];
    
    [super updateConstraints];
}



#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.bgImg];
    [self addSubview:self.view];
    [self addSubview:self.img];
    [self addSubview:self.icon];
    [self addSubview:self.name];
    [self addSubview:self.autograph];
    [self addSubview:self.star];
    [self addSubview:self.titleView];
    [self addSubview:self.titleViewText];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setEmployeeModel:(EmployeeModel *)employeeModel{
    if (!employeeModel) {
        return;
    }
    _employeeModel = employeeModel;
    self.name.text = employeeModel.empName;
    self.autograph.text = employeeModel.position;
    if (employeeModel.empName.length==3) {
        self.img.text = [employeeModel.empName substringFromIndex:1];
    }else{
        self.img.text = employeeModel.empName;
    }
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
        //        _name.text = @"黄慧";
        _name.font = H20;
        _name.textColor = white_color;
    }
    return _name;
}

-(UILabel *)autograph{
    if (!_autograph) {
        _autograph = [[UILabel alloc] init];
        //        _autograph.text = @"树欲静而风不止";
        _autograph.font = H14;
        _autograph.textColor = white_color;
    }
    return _autograph;
}

-(UIImageView *)star{
    if (!_star) {
        _star = [[UIImageView alloc] init];
        //        _star.image = ImageNamed(@"role_code_icon");
    }
    return _star;
}

-(UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] init];
        _view.backgroundColor = randomColorA;
        ViewRadius(_view, [self h_w:30]);
    }
    return _view;
}


-(UILabel *)img{
    if (!_img) {
        _img = [[UILabel alloc] init];
        _img.text = @"";
        _img.font = H20;
        _img.textColor = white_color;
        
    }
    return _img;
}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = GX_BGCOLOR;
    }
    return _titleView;
}

-(UILabel *)titleViewText{
    if (!_titleViewText) {
        _titleViewText = [[UILabel alloc] init];
        _titleViewText.text = @"基本信息";
        _titleViewText.font = H14;
        _titleViewText.textColor = MAIN_PAN_3;
    }
    return _titleViewText;
}

@end
