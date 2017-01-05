//
//  SetCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "SetCellView.h"


@interface SetCellView()

@property(nonatomic,strong) UIImageView *img;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UILabel *numbel;

@end



@implementation SetCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.img.mas_right).offset([self h_w:10]);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    
    [self.numbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.back.mas_left).offset(-[self h_w:10]);
    }];
  
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset([self h_w:1]);
        make.left.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    
    [super updateConstraints];
}


-(void)h_setupViews{
    
    [self addSubview:self.img];
    [self addSubview:self.title];
    [self addSubview:self.back];
    [self addSubview:self.line];
    [self addSubview:self.numbel];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark dataload
-(void)setSetModel:(SetModel *)setModel{
    if (!setModel) {
        return;
    }
    _setModel = setModel;
    self.img.image = ImageNamed(setModel.icon);
    self.title.text = setModel.title;
    self.numbel.text = setModel.number;
    
    

}


#pragma mark lazyload
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.image = ImageNamed(@"role_code_icon");
    }
    return _img;

}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
        _title.text = @"账户与";
    }
    return _title;
}


-(UIImageView *)back{
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = ImageNamed(@"role_right_arrow");
    }
    return _back;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BG_COLOR;
    }
    return _line;
}

-(UILabel *)numbel{
    if (!_numbel) {
        _numbel = [[UILabel alloc] init];
        _numbel.font = H14;
        _numbel.textColor = MAIN_PAN_2;
        _numbel.text = @"版本号1.0";
    }
    return _numbel;

}

@end
