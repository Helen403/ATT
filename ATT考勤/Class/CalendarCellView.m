//
//  CalendarCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/12.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CalendarCellView.h"

@interface CalendarCellView()

@property(nonatomic,strong) UIImageView *img;

@property(nonatomic,strong) UILabel *content;

@property(nonatomic,strong) UIButton *button;

@end

@implementation CalendarCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.img.mas_right).offset([self h_w:10]);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-[self h_w:10]);
        make.centerY.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake([self h_w:80], [self h_w:32]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.img];
    [self addSubview:self.content];
    [self addSubview:self.button];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setCalendarModel:(CalendarModel *)calendarModel{
    if (!calendarModel) {
        return;
    }
    _calendarModel = calendarModel;
    
    self.img.image = ImageNamed(calendarModel.img);
    self.content.text = calendarModel.content;
    [self.button setTitle:calendarModel.status forState:UIControlStateNormal];
}

#pragma mark lazyload
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.image = ImageNamed(@"settings_ detection_picture");
    }
    return _img;
}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.text = @"你忘记打卡";
        _content.font = H14;
        _content.textColor = MAIN_PAN_2;
    }
    return _content;
}

-(UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"登   陆" forState:UIControlStateNormal];
        _button.titleLabel.font = H14;
        [_button addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_button.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_button.layer setCornerRadius:10];
        
        [_button.layer setBorderWidth:2];//设置边界的宽度
        
        [_button setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){242/255.f,130/255.f,74/255.f,1});
        
        [_button.layer setBorderColor:color];
    }
    return _button;
}

-(void)Click{
    
    
}

@end
