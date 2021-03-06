//
//  CountCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/12.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CountCellView.h"

@interface CountCellView()

@property(nonatomic,strong) UIImageView *Img;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UILabel *number;

@property(nonatomic,strong) UIView *line;

@end

@implementation CountCellView
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
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
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
-(void)setCountModel:(CountModel *)countModel{
    if (!countModel) {
        return;
    }
    _countModel = countModel;
    self.Img.image = ImageNamed(countModel.imgtext);
    self.title.text = countModel.title;
    self.number.text = countModel.number;
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
