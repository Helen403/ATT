//
//  AboutCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AboutCellView.h"

@interface AboutCellView()

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *info;

@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UILabel *address;

@end

@implementation AboutCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.icon.mas_right).offset([self h_w:10]);
    }];
    
    [self.info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(weakSelf);
        make.right.equalTo(-[self h_w:10]);
        make.left.equalTo(SCREEN_WIDTH*0.4);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH*0.5, [self h_w:40]));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    
    [self addSubview:self.icon];
    [self addSubview:self.title];
    [self addSubview:self.info];
    [self addSubview:self.line];
    [self addSubview:self.address];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark dataload
-(void)setAboutModel:(AboutModel *)aboutModel{

    if (!aboutModel) {
        return;
    }
    _aboutModel = aboutModel;
    self.icon.image = ImageNamed(aboutModel.img);
    self.title.text = aboutModel.title;
    self.info.text = aboutModel.info;
    self.address.text = aboutModel.address;

}

#pragma mark lazyload
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = ImageNamed(@"role_code_icon");
    }
    return _icon;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
        _title.text = @"";
    }
    return _title;
}

-(UILabel *)info{
    if (!_info) {
        _info = [[UILabel alloc] init];
        _info.font = H14;
        _info.textColor = MAIN_PAN_2;
        _info.text = @"";
    }
    return _info;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

-(UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc] init];
        _address.font = H14;
        _address.textColor = MAIN_PAN_2;
        _address.text = @"";
        _address.numberOfLines = 0;
        _address.textAlignment = NSTextAlignmentRight;
    }
    return _address;
}


@end
