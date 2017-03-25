//
//  DailyCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DailyCellView.h"

@interface DailyCellView()

@property(nonatomic,strong) UIView *view;

@property(nonatomic,strong) UIView *bgView;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *shift;

@property(nonatomic,strong) UILabel *earlyWork; // 早退

@property(nonatomic,strong) UILabel *forgetWork; // 漏打卡

@property(nonatomic,strong) UILabel *lateWork; // 迟到

@property(nonatomic,strong) UILabel *goOutWork; // 外出

@property(nonatomic,strong) UILabel *offWork; // 请假

@property(nonatomic,strong) UILabel *outWork; // 出差

@property(nonatomic,strong) UILabel *overWork; // 加班

@property(nonatomic,strong) UIView *details;

@property(nonatomic,strong) UILabel *detailsText;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UIView *line;

@end

@implementation DailyCellView


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
        make.centerX.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.view.mas_top).offset([self h_w:10]);
        
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.time.mas_bottom).offset([self h_w:10]);
        make.left.equalTo([self h_w:6]);
        make.right.equalTo(weakSelf.view.mas_right).offset(-[self h_w:6]);
        
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-[self h_w:6]);
    }];
    
    [self.shift mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:10]);
    }];
    
    [self.earlyWork mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.shift.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(weakSelf.shift);
        make.bottom.equalTo(weakSelf.forgetWork.mas_top);
    }];
    
    [self.forgetWork mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.earlyWork.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(weakSelf.shift);
        make.bottom.equalTo(weakSelf.lateWork.mas_top);
    }];
    [self.lateWork mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.forgetWork.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(weakSelf.shift);
        make.bottom.equalTo(weakSelf.goOutWork.mas_top);
    }];
    [self.goOutWork mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lateWork.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(weakSelf.shift);
        make.bottom.equalTo(weakSelf.offWork.mas_top);
    }];
    [self.offWork mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goOutWork.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(weakSelf.shift);
        make.bottom.equalTo(weakSelf.outWork.mas_top);
    }];
    [self.outWork mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.offWork.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(weakSelf.shift);
        make.bottom.equalTo(weakSelf.overWork.mas_top);
    }];
    [self.overWork mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.outWork.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(weakSelf.shift);
        make.bottom.equalTo(weakSelf.line.mas_top).offset(-[self h_w:6]);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(weakSelf.overWork.mas_bottom).offset([self h_w:6]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
        make.bottom.equalTo(weakSelf.details.mas_top);
    }];
    
    
    [self.details mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:40]));
        
        make.bottom.equalTo(weakSelf.bgView.mas_bottom);
    }];
    [self.detailsText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.details);
        make.left.equalTo(weakSelf.shift);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.details);
        make.right.equalTo(weakSelf.bgView.mas_right).offset(-[self h_w:10]);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor =white_color;
    
    [self.contentView addSubview:self.view];
    [self.view addSubview:self.time];
    [self.view addSubview:self.bgView];
    
    [self.bgView addSubview:self.shift];
    [self.bgView addSubview:self.earlyWork];
    [self.bgView addSubview:self.forgetWork];
    [self.bgView addSubview:self.lateWork];
    [self.bgView addSubview:self.goOutWork];
    [self.bgView addSubview:self.offWork];
    [self.bgView addSubview:self.outWork];
    [self.bgView addSubview:self.overWork];
    [self.bgView addSubview:self.line];
    [self.bgView addSubview:self.details];
    [self.bgView addSubview:self.detailsText];
    
    [self.bgView addSubview:self.back];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    
    
}

#pragma mark dataload
-(void)setDailyModel:(DailyModel *)dailyModel{
    if (!dailyModel) {
        return;
    }
    _dailyModel = dailyModel;

    self.time.text = [LSCoreToolCenter getFormatterYMD:dailyModel.cardDate];
    self.shift.text = [NSString stringWithFormat:@"班次:%@",dailyModel.shiftName];
    Boolean flag = NO;
    if (![dailyModel.earlyWorkCount isEqualToString:@"0"]) {
        self.earlyWork.text = [NSString stringWithFormat:@"你有%@次早退",dailyModel.earlyWorkCount] ;
        flag = YES;
    }else{
        self.earlyWork.text = @"";
    }
    
    if (![dailyModel.forgetWorkCount isEqualToString:@"0"]) {
        
        self.forgetWork.text = [NSString stringWithFormat:@"你有%@次忘记打卡",dailyModel.forgetWorkCount] ;
        flag = YES;
    }else{
        self.forgetWork.text = @"";
    }
    
    if (![dailyModel.lateWorkCount isEqualToString:@"0"]) {
        
        self.lateWork.text = [NSString stringWithFormat:@"你有%@次迟到",dailyModel.lateWorkCount] ;
        flag = YES;
    }else{
        self.lateWork.text = @"";
    }
    
    if (![dailyModel.goOutWorkCount isEqualToString:@"0"]) {
        self.goOutWork.text = [NSString stringWithFormat:@"你有%@次外出",dailyModel.goOutWorkCount];
        flag = YES;
    }else{
        self.goOutWork.text = @"";
    }
    
    if (![dailyModel.offWorkCount isEqualToString:@"0"]) {
        self.offWork.text = [NSString stringWithFormat:@"你有%@次请假",dailyModel.offWorkCount] ;
        flag = YES;
    }else{
        self.offWork.text = @"";
    }
    
    
    if (![dailyModel.outWorkCount isEqualToString:@"0"]) {
        self.outWork.text = [NSString stringWithFormat:@"你有%@次出差",dailyModel.outWorkCount] ;
        flag = YES;
    }else{
        self.outWork.text = @"";
    }
    
    if (![dailyModel.overWorkCount isEqualToString:@"0"]) {
        self.overWork.text = [NSString stringWithFormat:@"你有%@次加班",dailyModel.overWorkCount] ;
        flag = YES;
    }else{
        self.overWork.text = @"";
    }
    if (!flag) {
        self.earlyWork.text = @"出勤正常";
    }
}


#pragma mark lazyload
-(UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] init];
    }
    return _view;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = GX_BGCOLOR;
        
        ViewRadius(_bgView, 6);
    }
    return _bgView;
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

-(UILabel *)shift{
    if (!_shift) {
        _shift = [[UILabel alloc] init];
        _shift.text = @"bancoi";
        _shift.font = H14;
        _shift.textColor = MAIN_PAN_2;
    }
    return _shift;
}




-(UILabel *)earlyWork{
    if (!_earlyWork) {
        _earlyWork = [[UILabel alloc] init];
        _earlyWork.text = @"";
        _earlyWork.font = H14;
        _earlyWork.textColor = MAIN_PAN_2;
    }
    return _earlyWork;
}


-(UILabel *)forgetWork{
    if (!_forgetWork) {
        _forgetWork = [[UILabel alloc] init];
        _forgetWork.text = @"";
        _forgetWork.font = H14;
        _forgetWork.textColor = MAIN_PAN_2;
    }
    return _forgetWork;
}


-(UILabel *)lateWork{
    if (!_lateWork) {
        _lateWork = [[UILabel alloc] init];
        _lateWork.text = @"";
        _lateWork.font = H14;
        _lateWork.textColor = MAIN_PAN_2;
    }
    return _lateWork;
}


-(UILabel *)goOutWork{
    if (!_goOutWork) {
        _goOutWork = [[UILabel alloc] init];
        _goOutWork.text = @"";
        _goOutWork.font = H14;
        _goOutWork.textColor = MAIN_PAN_2;
    }
    return _goOutWork;
}



-(UILabel *)offWork{
    if (!_offWork) {
        _offWork = [[UILabel alloc] init];
        _offWork.text = @"";
        _offWork.font = H14;
        _offWork.textColor = MAIN_PAN_2;
    }
    return _offWork;
}


-(UILabel *)outWork{
    if (!_outWork) {
        _outWork = [[UILabel alloc] init];
        _outWork.text = @"";
        _outWork.font = H14;
        _outWork.textColor = MAIN_PAN_2;
    }
    return _outWork;
}


-(UILabel *)overWork{
    if (!_overWork) {
        _overWork = [[UILabel alloc] init];
        _overWork.text = @"";
        _overWork.font = H14;
        _overWork.textColor = MAIN_PAN_2;
    }
    return _overWork;
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

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

@end
