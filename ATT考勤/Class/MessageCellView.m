//
//  MessageCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MessageCellView.h"

@interface MessageCellView()

@property(nonatomic,strong) UIImageView *img;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UISwitch *on;

@property(nonatomic,strong) UIView *line;

@end

@implementation MessageCellView

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
    
    [self.on mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
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
    [self addSubview:self.on];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setMessageModel:(MessageModel *)messageModel{
    if (!messageModel) {
        return;
    }
    _messageModel = messageModel;
    self.img.image = ImageNamed(messageModel.img);
    self.title.text= messageModel.title;
    if (self.index == 0) {
        NSString *announce =  [[NSUserDefaults standardUserDefaults] objectForKey:@"findIsReceAnnounce"];
        if ([announce isEqualToString:@"0"]) {
            [self.on setOn:YES];
        }else{
            [self.on setOn:NO];
        }
    }
    
    if (self.index == 1) {
        NSString *notice =  [[NSUserDefaults standardUserDefaults] objectForKey:@"findIsReceNotice"];
        if ([notice isEqualToString:@"0"]) {
            [self.on setOn:YES];
        }else{
            [self.on setOn:NO];
        }
    }
    if (self.index == 2) {
        NSString *news =  [[NSUserDefaults standardUserDefaults] objectForKey:@"findIsReceNews"];
        if ([news isEqualToString:@"0"]) {
            [self.on setOn:YES];
        }else{
            [self.on setOn:NO];
        }
    }
    
}


#pragma mark lazyload
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.image = ImageNamed(@"role_two_icon");
    }
    return _img;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"接收企业广告";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UISwitch *)on{
    if (!_on) {
        _on = [[UISwitch alloc] init];
        [_on addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _on;
}

-(void) switchAction:(UISwitch *)sender{
    if (self.index == 0) {
       
        if ([sender isOn]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"findIsReceAnnounce"];
        }else{
          [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"findIsReceAnnounce"];
        }

    }
    
    if (self.index == 1) {
        if ([sender isOn]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"findIsReceNotice"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"findIsReceNotice"];
        }

      
    }
    if (self.index == 2) {
        if ([sender isOn]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"findIsReceNews"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"findIsReceNews"];
        }
    }
   
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
    
}
@end
