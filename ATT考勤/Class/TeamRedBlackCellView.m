//
//  TeamRedBlackCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamRedBlackCellView.h"

@interface TeamRedBlackCellView()

@property(nonatomic,strong) UILabel *rank;

@property(nonatomic,strong) UILabel *sum;

@property(nonatomic,strong) UIImageView *img;

@property(nonatomic,strong) UILabel *department;

@property(nonatomic,strong) UILabel *attend;

@property(nonatomic,strong) UILabel *late;

@property(nonatomic,strong) UILabel *early;

@property(nonatomic,strong) UILabel *forget;

@end

@implementation TeamRedBlackCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-[self h_w:40], [self h_w:170]));
    }];
    
    
    [self.department mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.img.mas_left).offset(SCREEN_WIDTH*0.05);
        make.size.equalTo(CGSizeMake([self h_w:120], [self h_w:40]));
        
    }];
    
    [self.rank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.department);
        make.bottom.equalTo(weakSelf.department.mas_top).offset(-[self h_w:20]);
    }];
    
    [self.sum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.department);
        make.top.equalTo(weakSelf.department.mas_bottom).offset([self h_w:20]);
    }];
    
    
    [self.attend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.department.mas_right).offset(SCREEN_WIDTH*0.17);
        make.top.equalTo(weakSelf.img.mas_top).offset([self h_w:0]);
        make.size.equalTo(CGSizeMake([self h_w:120], [self h_w:40]));
    }];
    
    [self.late mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.attend);
        make.top.equalTo(weakSelf.attend.mas_top).offset([self h_w:42]);
        make.size.equalTo(CGSizeMake([self h_w:120], [self h_w:40]));
    }];
    [self.early mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.attend);
        make.top.equalTo(weakSelf.late.mas_top).offset([self h_w:45]);
        make.size.equalTo(CGSizeMake([self h_w:120], [self h_w:40]));
    }];
    
    [self.forget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.attend);
        make.top.equalTo(weakSelf.early.mas_top).offset([self h_w:43]);
        make.size.equalTo(CGSizeMake([self h_w:120], [self h_w:40]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    [self addSubview:self.rank];
    [self addSubview:self.sum];
    [self addSubview:self.img];
    [self addSubview:self.department];
    [self addSubview:self.attend];
    [self addSubview:self.late];
    [self addSubview:self.early];
    [self addSubview:self.forget];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)setTeamRedBlackModel:(TeamRedBlackModel *)teamRedBlackModel{
    if (!teamRedBlackModel) {
        return;
    }
    _teamRedBlackModel = teamRedBlackModel;
    
    self.sum.text = [NSString stringWithFormat:@"总分:%@",teamRedBlackModel.sumScore] ;
    self.rank.text =[NSString stringWithFormat:@"第%ld名",(long)self.index+1];
    self.department.text =[NSString stringWithFormat:@"%@",teamRedBlackModel.deptName];
    self.attend.text = [NSString stringWithFormat:@"正常出勤:%@次",teamRedBlackModel.normalCount];
    self.late.text = [NSString stringWithFormat:@"累计加班:%@次",teamRedBlackModel.overWorkCount];
    self.early.text = [NSString stringWithFormat:@"迟到早退:%@次",teamRedBlackModel.earlyLateWorkCount];
    self.forget.text = [NSString stringWithFormat:@"其他:%@次",teamRedBlackModel.otherWorkCount];
    if (self.index == 0) {
        self.img.image = ImageNamed(@"red_bg");
        
    }else if(self.index == self.count-1){
        self.img.image = ImageNamed(@"black_bg");
        
    }else{
        self.img.image = ImageNamed(@"greed_bg");
    }
    
    
    
}

#pragma mark lazyload
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
    }
    return _img;
}

-(UILabel *)department{
    if (!_department) {
        _department = [[UILabel alloc] init];
        
        _department.textAlignment = NSTextAlignmentCenter;
        _department.text = @"";
        _department.font = H14;
        _department.textColor = white_color;
    }
    return _department;
}

-(UILabel *)attend{
    if (!_attend) {
        _attend = [[UILabel alloc] init];
        
        _attend.textAlignment = NSTextAlignmentCenter;
        _attend.text = @"";
        _attend.font = H14;
        _attend.textColor = white_color;
    }
    return _attend;
}

-(UILabel *)late{
    if (!_late) {
        _late = [[UILabel alloc] init];
        
        _late.textAlignment = NSTextAlignmentCenter;
        _late.text = @"";
        _late.font = H14;
        _late.textColor = white_color;
    }
    return _late;
}
-(UILabel *)early{
    if (!_early) {
        _early = [[UILabel alloc] init];
        
        _early.textAlignment = NSTextAlignmentCenter;
        _early.text = @"";
        _early.font = H14;
        _early.textColor = white_color;
    }
    return _early;
}

-(UILabel *)forget{
    if (!_forget) {
        _forget = [[UILabel alloc] init];
        
        _forget.textAlignment = NSTextAlignmentCenter;
        _forget.text = @"";
        _forget.font = H14;
        _forget.textColor = white_color;
    }
    return _forget;
}

-(UILabel *)rank{
    if (!_rank) {
        _rank = [[UILabel alloc] init];
        _rank.text = @"";
        _rank.font = H14;
        _rank.textColor = MAIN_PAN_2;
    }
    return _rank;
}

-(UILabel *)sum{
    if (!_sum) {
        _sum = [[UILabel alloc] init];
        _sum.text = @"";
        _sum.font = H14;
        _sum.textColor = MAIN_PAN_2;
    }
    return _sum;
}

@end
