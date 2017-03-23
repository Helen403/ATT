//
//  TeamDailyDetailsHeadView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamDailyDetailsHeadView.h"

@interface TeamDailyDetailsHeadView()

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *event;

@property(nonatomic,strong) UILabel *state;

@property(nonatomic,strong) UIView *line2;

@end

@implementation TeamDailyDetailsHeadView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.mas_top).offset([self h_w:10]);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1.mas_bottom).offset([self h_w:10]);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.event mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2-[self h_w:50]);
        make.top.equalTo(weakSelf.name);
    }];
    
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/3*2+[self h_w:30]);
        make.top.equalTo(weakSelf.name);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:1]);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.line1];
    [self addSubview:self.name];
    [self addSubview:self.event];
    [self addSubview:self.state];
    [self addSubview:self.line2];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setDeptName:(NSString *)deptName{
    if (!deptName) {
        return;
    }
    _deptName = deptName;
    self.title.text = deptName;
}

#pragma mark lazyload
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line1;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line2;
}


-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"姓名";
        _name.font = H14;
        _name.textColor = MAIN_PAN_2;
    }
    return _name;
}

-(UILabel *)event{
    if (!_event) {
        _event = [[UILabel alloc] init];
        _event.text = @"事件";
        _event.font = H14;
        _event.textColor = MAIN_PAN_2;
    }
    return _event;
}

-(UILabel *)state{
    if (!_state) {
        _state = [[UILabel alloc] init];
        _state.text = @"状态";
        _state.font = H14;
        _state.textColor = MAIN_PAN_2;
    }
    return _state;
}

@end
