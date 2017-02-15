//
//  BuildRoleCellView.m
//  ATT考勤
//
//  Created by Helen on 17/2/13.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "BuildRoleCellView.h"

@interface BuildRoleCellView()

@property(nonatomic,strong) UIImageView *twoDimensionCodeImg;

@property(nonatomic,strong) UILabel *twoDimensionCodeTitle;

@property(nonatomic,strong) UILabel *twoDimensionCodeText;

@property(nonatomic,strong) UIImageView *twoDimensionCodeBack;

@property(nonatomic,strong) UIView *line1;

@end


@implementation BuildRoleCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.twoDimensionCodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.twoDimensionCodeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(weakSelf.twoDimensionCodeImg.mas_right).offset([self h_w:10]);
        make.top.equalTo([self h_w:7]);
    }];
    
    [self.twoDimensionCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(weakSelf.twoDimensionCodeTitle);
          make.top.equalTo(weakSelf.twoDimensionCodeTitle.mas_bottom).offset([self h_w:3]);
    }];
    
    [self.twoDimensionCodeBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
        
    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.twoDimensionCodeImg];
    [self addSubview:self.twoDimensionCodeTitle];
    [self addSubview:self.twoDimensionCodeText];
    [self addSubview:self.twoDimensionCodeBack];
    [self addSubview:self.line1];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark dataload
-(void)setBuildRoleModel:(BuildRoleModel *)buildRoleModel{
    if (!buildRoleModel) {
        return;
    }
    self.twoDimensionCodeImg.image = ImageNamed(buildRoleModel.img);
    self.twoDimensionCodeTitle.text = buildRoleModel.title;
    self.twoDimensionCodeText.text = buildRoleModel.text;

}

#pragma mark lazyload

-(UIImageView *)twoDimensionCodeImg{
    if (!_twoDimensionCodeImg) {
        _twoDimensionCodeImg = [[UIImageView alloc] init];
        _twoDimensionCodeImg.image = ImageNamed(@"role_two_icon");
    }
    return _twoDimensionCodeImg;
}

-(UILabel *)twoDimensionCodeTitle{
    if (!_twoDimensionCodeTitle) {
        _twoDimensionCodeTitle = [[UILabel alloc] init];
        _twoDimensionCodeTitle.text = @"扫码加入";
        _twoDimensionCodeTitle.font = H12;
    }
    return _twoDimensionCodeTitle;
    
}

-(UILabel *)twoDimensionCodeText{
    if (!_twoDimensionCodeText) {
        _twoDimensionCodeText = [[UILabel alloc] init];
        _twoDimensionCodeText.text = @"扫描公司提供的二维码";
        _twoDimensionCodeText.textColor = MAIN_PAN;
        _twoDimensionCodeText.font = H8;
    }
    return _twoDimensionCodeText;
    
}


-(UIImageView *)twoDimensionCodeBack{
    if (!_twoDimensionCodeBack) {
        _twoDimensionCodeBack = [[UIImageView alloc] init];
        _twoDimensionCodeBack.image = ImageNamed(@"role_right_arrow");
        
    }
    return _twoDimensionCodeBack;
}

-(UIView *)line1{
    if (!_line1) {
        _line1  = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line1;
}


@end
