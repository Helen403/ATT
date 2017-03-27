//
//  DailyDetailsHeadView.m
//  ATT考勤
//
//  Created by Helen on 17/3/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DailyDetailsHeadView.h"

@interface DailyDetailsHeadView()

@property(nonatomic,strong) UILabel *shift;

@property(nonatomic,strong) UILabel *count;

@property(nonatomic,strong) UIView *line;

@end

@implementation DailyDetailsHeadView


#pragma mark system


-(void)updateConstraints{
    
    WS(weakSelf);
    [self.shift mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:20]);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(SCREEN_WIDTH/2);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:1]);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.shift];
    [self addSubview:self.count];
    [self addSubview:self.line];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload




#pragma mark dataload
-(void)setDailyDetailsModel:(DailyDetailsModel *)dailyDetailsModel{
    if (!dailyDetailsModel) {
        return;
    }
    _dailyDetailsModel = dailyDetailsModel;
    self.shift.text = [NSString stringWithFormat:@"班次:%@",dailyDetailsModel.shiftName];
    self.count.text = [NSString stringWithFormat:@"打卡次数:%@次",dailyDetailsModel.signCount];
}

#pragma mark lazyload
-(UILabel *)shift{
    if (!_shift) {
        _shift = [[UILabel alloc] init];
        _shift.text = @"";
        _shift.font = H14;
        _shift.textColor = MAIN_PAN_2;
        
    }
    return _shift;
}

-(UILabel *)count{
    if (!_count) {
        _count = [[UILabel alloc] init];
        _count.text = @"";
        _count.font = H14;
        _count.textColor = MAIN_PAN_2;
    }
    return _count;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

@end
