//
//  TeamDailyCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamDailyCellView.h"

@interface TeamDailyCellView()

@property(nonatomic,strong) UIView *bgView;

@property(nonatomic,strong) UILabel *team;

@property(nonatomic,strong) UILabel *attend;

@property(nonatomic,strong) UILabel *lateWorkCount;

@property(nonatomic,strong) UILabel *earlyWorkCount;

@property(nonatomic,strong) UILabel *forgetWorkCount;

@property(nonatomic,strong) UILabel *goOutWorkCount;

@property(nonatomic,strong) UILabel *offWorkCount;

@property(nonatomic,strong) UILabel *overWorkCount;

@property(nonatomic,strong) UILabel *outWorkCount;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIView *details;

@property(nonatomic,strong) UILabel *detailsText;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIView *view;

@property(nonatomic,strong) UILabel *time;

@end

@implementation TeamDailyCellView

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
    
    [self.lateWorkCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.bgView).offset([self h_w:10]);
        make.top.equalTo(weakSelf.attend);
    }];
    
    [self.earlyWorkCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.attend);
        make.top.equalTo(weakSelf.attend.mas_bottom).offset([self h_w:6]);
    }];
    
    [self.forgetWorkCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.earlyWorkCount);
        make.left.equalTo(weakSelf.lateWorkCount);
    }];
    
    [self.goOutWorkCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.earlyWorkCount.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(weakSelf.attend);
    }];
    
    [self.offWorkCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goOutWorkCount);
        make.left.equalTo(weakSelf.lateWorkCount);
    }];
    
    [self.overWorkCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goOutWorkCount.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(weakSelf.attend);
    }];
    
    [self.outWorkCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.overWorkCount);
        make.left.equalTo(weakSelf.lateWorkCount);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(weakSelf.outWorkCount.mas_bottom).offset([self h_w:10]);
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
    [self.bgView addSubview:self.lateWorkCount];
    [self.bgView addSubview:self.earlyWorkCount];
    [self.bgView addSubview:self.forgetWorkCount];
    [self.bgView addSubview:self.goOutWorkCount];
    [self.bgView addSubview:self.offWorkCount];
    [self.bgView addSubview:self.overWorkCount];
    [self.bgView addSubview:self.outWorkCount];
    [self.bgView addSubview:self.details];
    [self.bgView addSubview:self.detailsText];
    [self.bgView addSubview:self.back];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setTeamDailyModel:(TeamDailyModel *)teamDailyModel{
    if (!teamDailyModel) {
        return;
    }
    _teamDailyModel = teamDailyModel;
    self.time.text = [LSCoreToolCenter getFormatterYMD:teamDailyModel.busDate];
    self.team.text = [NSString stringWithFormat:@"%@(%@人)",teamDailyModel.deptName,teamDailyModel.deptPersonCount] ;
    self.attend.text =[NSString stringWithFormat:@"出勤率为%.2f%%",teamDailyModel.normalRate.floatValue] ;
    self.lateWorkCount.text = [NSString stringWithFormat:@"迟到:%@人",teamDailyModel.lateWorkCount];
    self.earlyWorkCount.text = [NSString stringWithFormat:@"早退:%@人",teamDailyModel.earlyWorkCount];
    self.forgetWorkCount.text = [NSString stringWithFormat:@"漏打卡:%@人",teamDailyModel.forgetWorkCount];
    self.goOutWorkCount.text = [NSString stringWithFormat:@"外出:%@人",teamDailyModel.goOutWorkCount];
    self.offWorkCount.text = [NSString stringWithFormat:@"请假:%@人",teamDailyModel.offWorkCount];
    self.overWorkCount.text = [NSString stringWithFormat:@"加班:%@人",teamDailyModel.overWorkCount];
    self.outWorkCount.text = [NSString stringWithFormat:@"出差:%@人",teamDailyModel.outWorkCount];
    
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

-(UILabel *)lateWorkCount{
    if (!_lateWorkCount) {
        _lateWorkCount = [[UILabel alloc] init];
        _lateWorkCount.text = @"";
        _lateWorkCount.font = H14;
        _lateWorkCount.textColor = MAIN_PAN_2;
    }
    return _lateWorkCount;
}

-(UILabel *)earlyWorkCount{
    if (!_earlyWorkCount) {
        _earlyWorkCount = [[UILabel alloc] init];
        _earlyWorkCount.text = @"";
        _earlyWorkCount.font = H14;
        _earlyWorkCount.textColor = MAIN_PAN_2;
    }
    return _earlyWorkCount;
}
-(UILabel *)forgetWorkCount{
    if (!_forgetWorkCount) {
        _forgetWorkCount = [[UILabel alloc] init];
        _forgetWorkCount.text = @"";
        _forgetWorkCount.font = H14;
        _forgetWorkCount.textColor = MAIN_PAN_2;
    }
    return _forgetWorkCount;
}
-(UILabel *)goOutWorkCount{
    if (!_goOutWorkCount) {
        _goOutWorkCount = [[UILabel alloc] init];
        _goOutWorkCount.text = @"";
        _goOutWorkCount.font = H14;
        _goOutWorkCount.textColor = MAIN_PAN_2;
    }
    return _goOutWorkCount;
}
-(UILabel *)offWorkCount{
    if (!_offWorkCount) {
        _offWorkCount = [[UILabel alloc] init];
        _offWorkCount.text = @"";
        _offWorkCount.font = H14;
        _offWorkCount.textColor = MAIN_PAN_2;
    }
    return _offWorkCount;
}

-(UILabel *)overWorkCount{
    if (!_overWorkCount) {
        _overWorkCount = [[UILabel alloc] init];
        _overWorkCount.text = @"";
        _overWorkCount.font = H14;
        _overWorkCount.textColor = MAIN_PAN_2;
    }
    return _overWorkCount;
}
-(UILabel *)outWorkCount{
    if (!_outWorkCount) {
        _outWorkCount = [[UILabel alloc] init];
        _outWorkCount.text = @"";
        _outWorkCount.font = H14;
        _outWorkCount.textColor = MAIN_PAN_2;
    }
    return _outWorkCount;
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
