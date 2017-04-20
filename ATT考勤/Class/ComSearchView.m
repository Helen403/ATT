//
//  ComSearchView.m
//  ATT考勤
//
//  Created by Helen on 17/4/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ComSearchView.h"

@interface ComSearchView()

@property(nonatomic,strong) UIView *view;

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *text;

@end

@implementation ComSearchView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(weakSelf);
         make.centerX.equalTo(weakSelf);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH-[self h_w:20], [self h_w:30]));
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset([self h_w:10]);
        make.centerY.equalTo(weakSelf.view);
         make.size.equalTo(CGSizeMake([self h_w:15], [self h_w:15]));
    }];
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.icon.mas_right).offset([self h_w:8]);
        make.centerY.equalTo(weakSelf.view);
    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = RGBCOLOR(200, 200, 205);
    
    [self addSubview:self.view];
    [self.view addSubview:self.icon];
    [self.view addSubview:self.text];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload

-(UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] init];
        ViewRadius(_view, 5);
        _view.backgroundColor = white_color;
    }
    return _view;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = ImageNamed(@"ic_search");
    }
    return _icon;
}

-(UILabel *)text{
    if (!_text) {
        _text = [[UILabel alloc] init];
        _text.text = @"姓名/手机号";
        _text.font = H14;
        _text.textColor = MAIN_PAN_2;
    }
    return _text;
}

@end
