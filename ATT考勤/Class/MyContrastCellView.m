//
//  MyContrastCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyContrastCellView.h"

@interface MyContrastCellView()

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIView *line3;

@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UILabel *current;

@property(nonatomic,assign) CGFloat length;

@property(nonatomic,strong) UIView *line4;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,assign) CGFloat lineLength;

@end

@implementation MyContrastCellView

#pragma mark system
-(void)updateConstraints{

    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:55]);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake([self h_w:2],[self h_w:50]));
    }];
    
    [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line1.mas_right).offset(0);
        make.centerY.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(self.length,[self h_w:36]));
    }];

    [self.current mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.line.mas_right).offset([self h_w:10]);
    }];
    
    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
          make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:1]);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    CGFloat ff = self.lineLength;
    [self.line2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:55]+ff);
           make.centerY.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake([self h_w:1], [self h_w:50]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.line];
    [self addSubview:self.line1];
    [self addSubview:self.line3];
    [self addSubview:self.current];
    [self addSubview:self.line2];
    [self addSubview:self.line4];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload

-(void)setMyContrastModel:(MyContrastModel *)myContrastModel{
    if (!myContrastModel) {
        return;
    }
    
    _myContrastModel = myContrastModel;
    self.title.text =[NSString stringWithFormat:@"%@/%@",myContrastModel.day,myContrastModel.month] ;
    self.current.text = [NSString stringWithFormat:@"%.2f小时", myContrastModel.curMonthHours.floatValue];
    self.length = SCREEN_WIDTH * myContrastModel.curMonthHours.floatValue/18.00f;
    self.lineLength = SCREEN_WIDTH /18.00f*(self.average.floatValue);
   
    [self updateConstraints];
}


#pragma mark lazyload
-(UIView *)line4{
    if (!_line4) {
        _line4 = [[UIView alloc] init];
        _line4.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line4;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = yellow_color;
    }
    return _line2;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"1";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_ORANGER;
    }
    return _line;
}

-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_ORANGER;
    }
    return _line1;
}


-(UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = MAIN_ORANGER;
    }
    return _line3;
}

-(UILabel *)current{
    if (!_current) {
        _current = [[UILabel alloc] init];
        _current.text = @"";
        _current.font = H14;
        _current.textColor = MAIN_ORANGER;
    }
    return _current;
}
@end
