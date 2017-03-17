//
//  MultiRolesCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MultiRolesCellView.h"

@interface MultiRolesCellView();

@property(nonatomic,strong) UIImageView *img;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIImageView *back;

@end

@implementation MultiRolesCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
           make.centerY.equalTo(weakSelf);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.img.mas_right).offset([self h_w:10]);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(weakSelf);
       make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    
    self.backgroundColor = white_color;
    
    [self addSubview:self.img];
    [self addSubview:self.title];
    [self addSubview:self.back];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setMultiRolesModel:(MultiRolesModel *)multiRolesModel{
    if (!multiRolesModel) {
        return;
    }
    _multiRolesModel = multiRolesModel;
//    self.img.image = ImageNamed(multiRolesModel.img);
    self.title.text = multiRolesModel.companyNickName;
}

#pragma mark lazyload
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.image = ImageNamed(@"switch_role_company");
    }
    return _img;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"反馈类型";
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



@end
