//
//  TeamOutWorkCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamOutWorkCellView.h"


@interface TeamOutWorkCellView()

@property(nonatomic,strong) UIView *bgView;

@property(nonatomic,strong) UILabel *team;

@property(nonatomic,strong) UILabel *attend;


@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIView *details;

@property(nonatomic,strong) UILabel *detailsText;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIView *view;

@property(nonatomic,strong) UILabel *time;

@end

@implementation TeamOutWorkCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(0);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).offset([self h_w:10]);
        
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.time.mas_bottom).offset([self h_w:10]);
        make.left.equalTo([self h_w:6]);
        make.right.equalTo(weakSelf.view.mas_right).offset(-[self h_w:6]);
        
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-[self h_w:6]);
    }];
    
    
    [self.team mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:10]);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(weakSelf.team.mas_bottom).offset([self h_w:10]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.attend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.team);
        make.top.equalTo(weakSelf.line1.mas_bottom).offset([self h_w:6]);
    }];

    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(weakSelf.attend.mas_bottom).offset([self h_w:10]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.details mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line2.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:40]));
        
        make.bottom.equalTo(weakSelf.bgView.mas_bottom);
    }];
    [self.detailsText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.details);
        make.left.equalTo(weakSelf.attend);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.details);
        make.right.equalTo(weakSelf.bgView.mas_right).offset(-[self h_w:10]);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self.contentView addSubview:self.view];
    [self.view addSubview:self.time];
    [self.view addSubview:self.bgView];
    
    [self.bgView addSubview:self.line1];
    [self.bgView addSubview:self.line2];
    [self.bgView addSubview:self.attend];
    [self.bgView addSubview:self.team];
    
    
    [self.bgView addSubview:self.details];
    [self.bgView addSubview:self.detailsText];
    [self.bgView addSubview:self.back];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setTeamOutWorkModel:(TeamOutWorkModel *)teamOutWorkModel{
    if (!teamOutWorkModel) {
        return;
    }
    _teamOutWorkModel = teamOutWorkModel;
    
    self.time.text =[NSString stringWithFormat:@"%@",[LSCoreToolCenter getFormatterYM:teamOutWorkModel.month]];
    self.team.text = [NSString stringWithFormat:@"%@",teamOutWorkModel.deptName];
    self.attend.text =[NSString stringWithFormat:@"外勤次数:%@次/人",teamOutWorkModel.outWorkCount];
}

#pragma mark lazyload
-(UILabel *)attend{
    if (!_attend) {
        _attend = [[UILabel alloc] init];
        _attend.text = @"";
        _attend.font = H14;
        _attend.textColor = MAIN_PAN_2;
    }
    return _attend;
}

-(UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] init];
    }
    return _view;
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

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = GX_BGCOLOR;
        ViewRadius(_bgView, 6);
    }
    return _bgView;
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

-(UILabel *)team{
    if (!_team) {
        _team = [[UILabel alloc] init];
        _team.text = @"";
        _team.font = H14;
        _team.textColor = MAIN_PAN_2;
    }
    return _team;
}




-(UIView *)details{
    if (!_details) {
        _details = [[UIView alloc] init];
    }
    return _details;
}
-(UILabel *)detailsText{
    if (!_detailsText) {
        _detailsText = [[UILabel alloc] init];
        _detailsText.text = @"查看详情";
        _detailsText.font = H14;
        _detailsText.textColor = MAIN_PAN_2;
    }
    return _detailsText;
}

-(UIImageView *)back{
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = ImageNamed(@"role_right_arrow");
    }
    return _back;
}


@end
