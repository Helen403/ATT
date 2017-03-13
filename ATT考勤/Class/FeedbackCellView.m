//
//  FeedbackCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/13.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "FeedbackCellView.h"

@interface FeedbackCellView()

@property(nonatomic,strong) UILabel *myTitle;

@property(nonatomic,strong) UILabel *myProblem;

@property(nonatomic,strong) UILabel *myFeedback;

@property(nonatomic,strong) UILabel *sysFeedback;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UIView *line;

@end

@implementation FeedbackCellView

#pragma mark system

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.myTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:10]);
    }];
    
    [self.myProblem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:20]);
        make.top.equalTo(weakSelf.myTitle.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.myFeedback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([self h_w:70]);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.sysFeedback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:20]);
        make.top.equalTo(weakSelf.myFeedback.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
        make.top.equalTo(weakSelf.myFeedback.mas_bottom).offset([self h_w:50]);
    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
        make.top.equalTo(weakSelf.name.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(0);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:1]);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.myTitle];
    [self addSubview:self.myProblem];
    [self addSubview:self.myFeedback];
    [self addSubview:self.sysFeedback];
    [self addSubview:self.name];
    [self addSubview:self.time];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setFeedbackModel:(FeedbackModel *)feedbackModel{
    if (!feedbackModel) {
        return;
    }
    _feedbackModel = feedbackModel;
    
    self.myProblem.text = feedbackModel.suggQuestion;
    self.time.text = feedbackModel.suggDatetime;
    
    
}




#pragma mark lazyload
-(UILabel *)myTitle{
    if (!_myTitle) {
        _myTitle = [[UILabel alloc] init];
        _myTitle.text = @"我的意见";
        _myTitle.font = H15;
        _myTitle.textColor = MAIN_PAN_2;
    }
    return _myTitle;
}

-(UILabel *)myProblem{
    if (!_myProblem) {
        _myProblem = [[UILabel alloc] init];
        _myProblem.text = @"";
        _myProblem.font = H14;
        _myProblem.textColor = MAIN_PAN_2;
    }
    return _myProblem;
}

-(UILabel *)myFeedback{
    if (!_myFeedback) {
        _myFeedback = [[UILabel alloc] init];
        _myFeedback.text = @"意见反馈";
        _myFeedback.font = H15;
        _myFeedback.textColor = MAIN_PAN_2;
    }
    return _myFeedback;
}

-(UILabel *)sysFeedback{
    if (!_sysFeedback) {
        _sysFeedback = [[UILabel alloc] init];
        _sysFeedback.text = @"暂时没反馈纪录";
        _sysFeedback.font = H14;
        _sysFeedback.textColor = MAIN_PAN_2;
    }
    return _sysFeedback;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"管理员";
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

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

@end
