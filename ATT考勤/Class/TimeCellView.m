//
//  TimeCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TimeCellView.h"

@interface TimeCellView()

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UISwitch *on;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UILabel *info;

@property(nonatomic,strong) UIView *line;


@end

@implementation TimeCellView

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
    
    [self.on mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
        
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
      make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    
    [self.info mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    self.backgroundColor = white_color;
    
    [self addSubview:self.icon];
    [self addSubview:self.title];
    [self addSubview:self.on];
    [self addSubview:self.back];
    [self addSubview:self.info];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setTimeModel:(TimeModel *)timeModel{
    if (!timeModel) {
        return;
    }
    _timeModel = timeModel;
    self.icon.image = ImageNamed(timeModel.icon);
    self.title.text = timeModel.title;
    if ([timeModel.on isEqualToString:@"1"]) {
        self.on.hidden = NO;
        self.back.hidden = YES;
        self.info.hidden = YES;
    }else {
        self.on.hidden = YES;
        self.back.hidden = NO;
        self.info.hidden = NO;
        self.info.text = timeModel.info;
    }
    
    
    if (self.index == 0) {
        NSString *cardSound =  [[NSUserDefaults standardUserDefaults] objectForKey:@"findIsCardSound"];
        if ([cardSound isEqualToString:@"0"]) {
            [self.on setOn:YES];
        }else{
            [self.on setOn:NO];
        }
    }
    
    if (self.index == 1) {
        NSString *sound =  [[NSUserDefaults standardUserDefaults] objectForKey:@"Sound"];
        self.info.text = sound;
    }
    
    
    if (self.index == 2) {
        NSString *cardVarient =  [[NSUserDefaults standardUserDefaults] objectForKey:@"findIsCardVarient"];
        if ([cardVarient isEqualToString:@"0"]) {
            [self.on setOn:YES];
        }else{
            [self.on setOn:NO];
        }
    }
}


#pragma mark lazyload

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
//        _icon.image = ImageNamed(@"role_code_icon");
    }
    return _icon;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
        _title.text = @"打卡声音";
    }
    return _title;
}


-(UISwitch *)on{
    if (!_on) {
        _on = [[UISwitch alloc] init];
        _on.hidden = YES;
        [_on addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _on;
}

-(void) switchAction:(UISwitch *)sender{
    if (self.index == 0) {
        
        if ([sender isOn]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"findIsCardSound"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"findIsCardSound"];
        }
        
    }
    
  
    if (self.index == 2) {
        if ([sender isOn]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"findIsCardVarient"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"findIsCardVarient"];
        }
    }
    
}
-(UIImageView *)back{
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = ImageNamed(@"role_right_arrow");
        _back.hidden = YES;
    }
    return _back;
}

-(UILabel *)info{
    if (!_info) {
        _info = [[UILabel alloc] init];
        _info.font = H14;
        _info.textColor = MAIN_PAN_2;
        _info.text = @"默认";
        _info.hidden = YES;
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

@end
