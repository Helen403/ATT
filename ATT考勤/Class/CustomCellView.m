//
//  CustomCellViewSection1.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CustomCellView.h"

@interface CustomCellView()

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *content1;

@property(nonatomic,strong) UILabel *content2;

@property(nonatomic,strong) UIImageView *back;

@end

@implementation CustomCellView

#pragma mark system


-(void)updateConstraints{
    
    WS(weakSelf);
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.content1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.icon.mas_right).offset([self h_w:10]);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.content2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.icon];
    [self addSubview:self.content1];
    [self addSubview:self.content2];
    [self addSubview:self.back];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setCustomModel:(CustomModel *)customModel{
    if (!customModel) {
        return;
    }
    _customModel = customModel;
    self.icon.image =ImageNamed(customModel.img);
    self.content1.text = customModel.content;
    self.content2.text = customModel.content;
    
    if ([customModel.img isEqualToString:@"0"]) {
        self.icon.hidden = YES;
        self.content1.hidden = YES;
        self.content2.hidden = NO;
        self.back.hidden = NO;
        
    }else{
        self.icon.hidden = NO;
        self.content1.hidden = NO;
        self.content2.hidden = YES;
        self.back.hidden = YES;
    }
    
}


#pragma mark lazyload
-(UIImageView *)icon{

    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = ImageNamed(@"role_code_icon");
    }
    return _icon;
}


-(UILabel *)content1{
    if (!_content1) {
        _content1 = [[UILabel alloc] init];
        _content1.font = H14;
        _content1.textColor = MAIN_PAN_2;
        _content1.text = @"联系电话";
        _content1.hidden = YES;
    }
    return _content1;
}

-(UILabel *)content2{
    if (!_content2) {
        _content2 = [[UILabel alloc] init];
        _content2.font = H14;
        _content2.textColor = MAIN_PAN_2;
        _content2.text = @"联系电话";
        _content2.hidden = YES;
    }
    return _content2;
}

-(UIImageView *)back{
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = ImageNamed(@"role_right_arrow");
       
    }
    return _back;

}

@end
