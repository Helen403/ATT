//
//  TeamAttendanceCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamAttendanceCellView.h"

@interface TeamAttendanceCellView()

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *number;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UIView *bgLine;

@end

@implementation TeamAttendanceCellView

#pragma mark system
-(void)updateConstraints{
    
    
    CGFloat length = arc4random_uniform(SCREEN_WIDTH-[self h_w:20]);
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.back.mas_left).offset(-[self h_w:10]);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:4]);
        make.left.equalTo([self h_w:10]);
        make.size.equalTo(CGSizeMake(length-[self h_w:20], [self h_w:4]));
    }];
    
    [self.bgLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-[self h_w:20], [self h_w:4]));
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:4]);
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.number];
    [self addSubview:self.back];
    [self addSubview:self.bgLine];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setTeamAttendanceModel:(TeamAttendanceModel *)teamAttendanceModel{
    if (!teamAttendanceModel) {
        return;
    }
    
    _teamAttendanceModel = teamAttendanceModel;
    self.title.text = teamAttendanceModel.title;
    self.number.text =teamAttendanceModel.number;
}

#pragma mark lazyload
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"反馈类型";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UILabel *)number{
    if (!_number) {
        _number = [[UILabel alloc] init];
        _number.text = @"反馈类型";
        _number.font = H14;
        _number.textColor = MAIN_PAN_2;
    }
    return _number;
}

-(UIImageView *)back{
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = ImageNamed(@"role_right_arrow");
    }
    return _back;
}


-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
       
    }
    return _line;
}

-(UIView *)bgLine{
    if (!_bgLine) {
        _bgLine = [[UIView alloc] init];
        _bgLine.backgroundColor = BG_COLOR;
    }
    return _bgLine;
}

@end
