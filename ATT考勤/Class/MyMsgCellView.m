//
//  MyMsgCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyMsgCellView.h"

@interface MyMsgCellView()

@property(nonatomic,strong) UIImageView *img;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *content;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UILabel *count;

@end

@implementation MyMsgCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(weakSelf.img.mas_right).offset([self h_w:5]);
         make.top.equalTo(weakSelf.img.mas_top).offset(-[self h_w:5]);
         make.size.equalTo(CGSizeMake([self h_w:16], [self h_w:16]));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.img.mas_top).offset(0);
        make.left.equalTo(weakSelf.img.mas_right).offset([self h_w:10]);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:2]);
        make.left.equalTo(weakSelf.img.mas_right).offset([self h_w:10]);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.img.mas_top).offset(0);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
          make.bottom.equalTo(weakSelf.mas_bottom).offset([self h_w:1]);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.img];
    [self addSubview:self.title];
    [self addSubview:self.content];
    [self addSubview:self.time];
    [self addSubview:self.line];
    [self addSubview:self.count];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setMyMsgModel:(MyMsgModel *)myMsgModel{
    if (!myMsgModel) {
        return;
    }
    _myMsgModel = myMsgModel;
    self.img.image = ImageNamed(@"remind_set_vioce_prompt_picture");
    self.title.text = myMsgModel.msgUserName;
    self.content.text = myMsgModel.msgLast;
    self.time.text = myMsgModel.msgDate;
    self.count.text = myMsgModel.msgSize;
}


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.count.backgroundColor = MAIN_RED;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.count.backgroundColor = MAIN_RED;
    
}


#pragma mark lazyload
-(UILabel *)count{
    if (!_count) {
        _count = [[UILabel alloc] init];
        _count.text = @"";
        _count.font = H12;
        _count.textColor = white_color;
        _count.backgroundColor = MAIN_RED;
        _count.textAlignment = NSTextAlignmentCenter;
        ViewRadius(_count, [self h_w:8]);
    }
    return _count;
}

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
        _title.text = @"";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;

}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.text = @"";
        _content.font = H12;
        _content.textColor = MAIN_PAN;
    }
    return _content;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"";
        _time.font = H12;
        _time.textColor = MAIN_PAN_2;
    }
    return _time;
}


-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}
@end
