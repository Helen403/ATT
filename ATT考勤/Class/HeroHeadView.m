//
//  HeroHeadView.m
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HeroHeadView.h"

@interface HeroHeadView()

@property(nonatomic,strong) UILabel *frist;

@property(nonatomic,strong) UILabel *fristContent;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *titleContent;

@property(nonatomic,strong) UILabel *rank;

@property(nonatomic,strong) UILabel *rankContent;

@property(nonatomic,strong) UILabel *ranking;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UIImageView *img;

@property(nonatomic,strong) UIView *titleView;

@property(nonatomic,strong) UILabel *titleViewText;

@end

@implementation HeroHeadView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    CGFloat length = SCREEN_WIDTH *0.3;

    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
         make.left.equalTo(0);
         make.right.equalTo(0);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:170]));
    }];
    
    [self.fristContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf).offset([self h_w:10]);
        //make.left.equalTo();
        make.centerX.equalTo(-length-[self h_w:15]);
    }];
    
    [self.frist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.fristContent.mas_top).offset(-[self h_w:10]);
        make.centerX.equalTo(weakSelf.fristContent);
    }];
    
    [self.titleContent mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf).offset(-[self h_w:5]);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.titleContent.mas_top).offset(-[self h_w:10]);
        make.centerX.equalTo(weakSelf);
    }];
    [self.rankContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf).offset([self h_w:10]);
        make.centerX.equalTo(length+[self h_w:15]);
    }];
    
    [self.rank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.rankContent.mas_top).offset(-[self h_w:10]);
        make.centerX.equalTo(weakSelf.rankContent);
    }];
    
    [self.ranking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleContent.mas_bottom).offset([self h_w:10]);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.ranking.mas_bottom).offset([self h_w:10]);
        make.centerX.equalTo(weakSelf);
    }];
    
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.img.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:30]));
    }];
    
    [self.titleViewText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.titleView);
        make.left.equalTo([self h_w:10]);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.img];
    [self addSubview:self.fristContent];
    [self addSubview:self.frist];
    [self addSubview:self.titleContent];
    [self addSubview:self.title];
    [self addSubview:self.rankContent];
    [self addSubview:self.rank];
    [self addSubview:self.ranking];
    [self addSubview:self.time];
    [self addSubview:self.titleView];
    [self addSubview:self.titleViewText];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setHeroModel:(HeroModel *)heroModel{
    if (!heroModel) {
        return;
    }
    _heroModel = heroModel;
    NSString *hour = [NSString stringWithFormat:@"%.f",heroModel.workHours.floatValue];
    self.frist.text = [hour substringToIndex:hour.length];
    self.title.text = [hour substringToIndex:hour.length];
    if (self.index<4) {
        self.rank.text = [NSString stringWithFormat:@"第%ld名",(long)self.index];
    }else{
        self.rank.text = @"未上榜";
    }
    self.time.text = [NSString stringWithFormat:@"(统计时间为:%ld月1日-%ld月%@日)",(long)[LSCoreToolCenter month1],(long)[LSCoreToolCenter month1],[LSCoreToolCenter getCurrentD]];
    
}


#pragma mark lazyload
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.image = ImageNamed(@"rankimg");
        [_img setContentMode:UIViewContentModeTop];
        
        _img.clipsToBounds = YES;
    }
    return _img;
}

-(UILabel *)fristContent{
    if (!_fristContent) {
        _fristContent = [[UILabel alloc] init];
        _fristContent.text = @"今日工时";
        _fristContent.font = H12;
        _fristContent.textColor = white_color;
    }
    return _fristContent;
}

-(UILabel *)frist{
    if (!_frist) {
        _frist = [[UILabel alloc] init];
        _frist.text = @"";
        _frist.font = H20;
        _frist.textColor = white_color;
    }
    return _frist;
}

-(UILabel *)titleContent{
    if (!_titleContent) {
        _titleContent = [[UILabel alloc] init];
        _titleContent.text = @"总工时";
        _titleContent.font = H14;
        _titleContent.textColor = white_color;
    }
    return _titleContent;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"";
        _title.font = H30;
        _title.textColor = white_color;
    }
    return _title;
}

-(UILabel *)rankContent{
    if (!_rankContent) {
        _rankContent = [[UILabel alloc] init];
        _rankContent.text = @"今日排名";
        _rankContent.font = H12;
        _rankContent.textColor = white_color;
    }
    return _rankContent;
}

-(UILabel *)rank{
    if (!_rank) {
        _rank = [[UILabel alloc] init];
        _rank.text = @"";
        _rank.font = H20;
        _rank.textColor = white_color;
    }
    return _rank;
}

-(UILabel *)ranking{
    if (!_ranking) {
        _ranking = [[UILabel alloc] init];
        _ranking.text = @"工时排行榜";
        _ranking.font = H15;
        _ranking.textColor = white_color;
    }
    return _ranking;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"";
        _time.font = H12;
        _time.textColor = white_color;
    }
    return _time;
}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = GX_BGCOLOR;
    }
    return _titleView;
}

-(UILabel *)titleViewText{
    if (!_titleViewText) {
        _titleViewText = [[UILabel alloc] init];
        _titleViewText.text = @"具体排行";
        _titleViewText.font = H13;
        _titleViewText.textColor = MAIN_PAN_3;
    }
    return _titleViewText;
}


@end
