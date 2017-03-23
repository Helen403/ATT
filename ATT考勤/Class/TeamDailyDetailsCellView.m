//
//  TeamDailyDetailsCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamDailyDetailsCellView.h"

@interface TeamDailyDetailsCellView()

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *state;

@property(nonatomic,strong) UIView *line;

@end

@implementation TeamDailyDetailsCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.centerY.equalTo(weakSelf);
    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SCREEN_WIDTH/2-[self h_w:50]);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(SCREEN_WIDTH/3*2+[self h_w:30]);
    }];
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:1]);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    [super updateConstraints];
}

-(void)setTeamDailyDetailsModel:(TeamDailyDetailsModel *)teamDailyDetailsModel{
    if (!teamDailyDetailsModel) {
        return;
    }
    _teamDailyDetailsModel = teamDailyDetailsModel;
    if ((self.index+1)%2==0) {
        self.line.hidden = NO;
    }else{
        self.line.hidden = YES;
    }
    
    _teamDailyDetailsModel = teamDailyDetailsModel;
    if (![teamDailyDetailsModel.empName isEqualToString:@""]) {
        self.name.text = teamDailyDetailsModel.empName;
    }else{
        self.name.text = @"";
    }
    
    self.time.text = teamDailyDetailsModel.cardTime;

    if ([teamDailyDetailsModel.cardStatus isEqualToString:@"0"]) {
        self.state.text = @"正常";
    }
    if ([teamDailyDetailsModel.cardStatus isEqualToString:@"1"]) {
          self.state.text = @"早退";
    }
    if ([teamDailyDetailsModel.cardStatus isEqualToString:@"2"]) {
        self.state.text = @"迟到";
      
    }
    if ([teamDailyDetailsModel.cardStatus isEqualToString:@"3"]) {
        self.state.text = @"漏打卡";
    }
    
    
}


#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.name];
    [self addSubview:self.time];
    [self addSubview:self.state];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"";
        _name.font = H14;
        _name.textColor = MAIN_PAN_2;
    }
    return _name;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"";
        _time.font = H14;
        _time.textColor = MAIN_PAN_2;
    }
    return _time;
}


-(UILabel *)state{
    if (!_state) {
        _state = [[UILabel alloc] init];
        _state.text = @"";
        _state.font = H14;
        _state.textColor = MAIN_PAN_2;
    }
    return _state;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
        _line.hidden = YES;
    }
    return _line;
}
@end
