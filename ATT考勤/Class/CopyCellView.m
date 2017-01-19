//
//  CopyCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CopyCellView.h"

@interface CopyCellView()

@property(nonatomic,strong) UIImageView *Img;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UILabel *number;

@property(nonatomic,strong) UIView *line;

@end

@implementation CopyCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
        make.size.equalTo(CGSizeMake([self h_w:25], [self h_w:25]));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.Img.mas_right).offset([self h_w:10]);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.back.mas_left).offset(-[self h_w:10]);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(1);
        make.left.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    
    [super updateConstraints];
}


#pragma mark private
-(void)h_setupViews{
    
    
    [self addSubview:self.Img];
    [self addSubview:self.title];
    [self addSubview:self.number];
    [self addSubview:self.back];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark loaddata
-(void)setToMeModel:(CopyToMeModel *)toMeModel{
    if (!toMeModel) {
        return;
    }
    _toMeModel = toMeModel;
    self.Img.image = ImageNamed(toMeModel.imgtext);
    self.title.text = toMeModel.title;
    self.number.text = toMeModel.number;
    
}


-(UIImageView *)Img{
    if (!_Img) {
        _Img = [[UIImageView alloc] init];
        _Img.image = ImageNamed(@"role_code_icon");
    }
    return _Img;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
        _title.text = @"待处理";
    }
    return _title;
    
}

-(UILabel *)number{
    if (!_number) {
        _number = [[UILabel alloc] init];
        _number.text = @"1";
        _number.textColor = MAIN_PAN_2;
        _number.font = H14;
    }
    return _number;
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


@end
