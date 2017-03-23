//
//  MonthDetailsCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MonthDetailsCellView.h"


@interface MonthDetailsCellView()

@property(nonatomic,strong) UILabel *cardDate;

@property(nonatomic,strong) UILabel *cardTime;

@property(nonatomic,strong) UIButton *state;

@property(nonatomic,strong) UIView *line;

@end

@implementation MonthDetailsCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.cardDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    [self.cardTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(SCREEN_WIDTH/2-[self h_w:30]);
    }];
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
        make.size.equalTo(CGSizeMake([self h_w:70], [self h_w:30]));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:1]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
        
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.cardDate];
    [self addSubview:self.cardTime];
    [self addSubview:self.state];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setMonthDetailsModel:(MonthDetailsModel *)monthDetailsModel{
    if (!monthDetailsModel) {
        return;
    }
    _monthDetailsModel = monthDetailsModel;

    if(![monthDetailsModel.cardDate isEqualToString:@""]){
        NSString *head = [LSCoreToolCenter getFormatter:[monthDetailsModel.cardDate substringToIndex:10]];
        NSString *end = [monthDetailsModel.cardDate substringFromIndex:10];
        self.cardDate.text = [NSString stringWithFormat:@"%@%@",head,end];
    }else{
        self.cardDate.text = @"";
    }
    self.cardTime.text = monthDetailsModel.cardTime;
    
    if ((self.index+1)%2==0) {
        self.line.hidden = NO;
    }else{
        self.line.hidden = YES;
    }
    
    if ([monthDetailsModel.cardStatus isEqualToString:@"0"]) {
        
        self.state.hidden = YES;
        
    }
    if ([monthDetailsModel.cardStatus isEqualToString:@"1"]) {
        
        [self.state setTitle:@"消早退" forState:UIControlStateNormal];
        self.state.hidden = NO;
    }
    if ([monthDetailsModel.cardStatus isEqualToString:@"2"]) {
        
        [self.state setTitle:@"消迟到" forState:UIControlStateNormal];
        self.state.hidden = NO;
    }
    if ([monthDetailsModel.cardStatus isEqualToString:@"3"]) {
        
        [self.state setTitle:@"漏打卡" forState:UIControlStateNormal];
        self.state.hidden = NO;
    }
}



#pragma mark lazyload
-(UILabel *)cardDate{
    if (!_cardDate) {
        _cardDate = [[UILabel alloc] init];
        _cardDate.text = @"";
        _cardDate.font = H14;
        _cardDate.textColor = MAIN_PAN_2;
    }
    return _cardDate;
}

-(UILabel *)cardTime{
    if (!_cardTime) {
        _cardTime = [[UILabel alloc] init];
        _cardTime.text = @"";
        _cardTime.font = H14;
        _cardTime.textColor = MAIN_PAN_2;
    }
    return _cardTime;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
        _line.hidden = YES;
    }
    return _line;
}

-(UIButton *)state{
    if (!_state) {
        _state = [[UIButton alloc] init];
        //[_startButton setTitle:@"登   录" forState:UIControlStateNormal];
        _state.titleLabel.font = H14;
        [_state addTarget:self action:@selector(stateClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_state.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_state.layer setCornerRadius:10];
        
        [_state.layer setBorderWidth:2];//设置边界的宽度
        
        [_state setBackgroundColor:MAIN_ORANGER];
        
        [_state.layer setBorderColor:MAIN_ORANGER.CGColor];
        _state.hidden = YES;
    }
    return _state;
}

-(void)stateClick:(UIButton *)button{
}


@end
