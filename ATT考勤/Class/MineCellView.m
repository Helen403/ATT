//
//  MineCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MineCellView.h"

@interface MineCellView()

@property(nonatomic,strong) UIImageView *img;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *info;

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UIView *line;

@end

@implementation MineCellView

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
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:30]);
         make.size.equalTo(CGSizeMake([self h_w:30], [self h_w:30]));
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    
    
    [self.info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:30]);
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
    [self addSubview:self.icon];
    [self addSubview:self.info];
    [self addSubview:self.back];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark loaddata
-(void)setMineModel:(MineModel *)mineModel{
    if (!mineModel) {
        return;
    }
    _mineModel = mineModel;
    
    self.img.image = ImageNamed(mineModel.img);
    self.title.text = mineModel.title;
    self.icon.image = ImageNamed(mineModel.icon);
    self.info.text = mineModel.info;
    if ([mineModel.back isEqualToString:@"1"]) {
        self.back.hidden = NO;
    }
}

-(void)setUserModel:(UserModel *)userModel{
    if (!userModel) {
        return;
    }
    _userModel = userModel;
    switch (self.index) {
            //我的头像
        case 0:{
            
            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"imgIcon"];
            if (str != nil) {
                [self.icon sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:ImageNamed(defaultImg)];
            }
            break;
        }
            //我的名字
        case 1:{
            self.info.text = userModel.userNickName;
            break;
        }
            //我的签名
        case 2:{
            NSString *signName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"signName"];
            self.info.text = signName;
            break;
        }
            //我的公司
        case 3:{
            NSString *companyNickName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyNickName"];
            self.info.text = companyNickName;
            break;
        }
            //我的积分
        case 4:{
            NSString *cardScore =  [[NSUserDefaults standardUserDefaults] objectForKey:@"cardScore"];
            self.info.text =[NSString stringWithFormat:@"%@分",cardScore] ;
            
            break;
        }
            //我的排班
        case 5:{
            self.info.text = @"";
            break;
        }
            //我的假期
        case 6:{
            NSString *myHoldays =  [[NSUserDefaults standardUserDefaults] objectForKey:@"findMyHoldays"];
            self.info.text = [NSString stringWithFormat:@"%@分钟",myHoldays];
            break;
        }
    }
    
}


#pragma mark lazyload

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
        _title.text = @"我的头像";
    }
    return _title;
    
}

-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.image = ImageNamed(@"");
    }
    return _img;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        ViewRadius(_icon, 3);
    }
    return _icon;
    
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


-(UIImageView *)back{
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = ImageNamed(@"role_right_arrow");
        _back.hidden = YES;
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
