//
//  NewCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "NewCellView.h"

@interface NewCellView()

@property(nonatomic,strong) UIImageView *img;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *number;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UIView *line;

@end

@implementation NewCellView

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
  
    [self addSubview:self.img];
    [self addSubview:self.title];
    [self addSubview:self.number];
    [self addSubview:self.back];
    [self addSubview:self.line];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setNewsModel:(NewsModel *)newsModel{
    if (!newsModel) {
        return;
    }
    _newsModel = newsModel;
    
    self.img.image = ImageNamed(newsModel.img);
    self.title.text = newsModel.title;
    self.number.text = newsModel.number;
}

#pragma mark lazyload
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.image = ImageNamed(@"");
    }
    return _img;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"公司公告";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
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

-(UILabel *)number{
    if (!_number) {
        _number = [[UILabel alloc] init];
        _number.text = @"1";
        _number.font = H14;
        _number.textColor = MAIN_PAN_2;
    }
    return _number;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

@end
