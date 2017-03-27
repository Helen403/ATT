//
//  InformListCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "InformListCellView.h"

@interface InformListCellView()

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *team;

@property(nonatomic,strong) UILabel *content;

@property(nonatomic,strong) UILabel *state;

@property(nonatomic,strong) UIView *line;

@end

@implementation InformListCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:10]);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.title.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.title);
    }];
    
    [self.team mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.time.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.title);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.time);
        make.top.equalTo(weakSelf.time.mas_bottom).offset([self h_w:4]);
    }];
    
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
        make.top.equalTo(weakSelf.title.mas_top);
    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.time];
    [self addSubview:self.team];
    [self addSubview:self.content];
    [self addSubview:self.state];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setInformListModel:(InformListModel *)informListModel{
    if (!informListModel) {
        return;
    }
    _informListModel = informListModel;
    self.title.text =[NSString stringWithFormat:@"%ld",(long)self.index+1];
    self.time.text = informListModel.msgPublishDate;
    self.team.text = informListModel.msgOffice;
    
    if ([informListModel.msgStatus isEqualToString:@"0"]) {
        self.state.text = @"未阅读";
        self.state.textColor = MAIN_RED;
    }else{
        self.state.text = @"已阅读";
        self.state.textColor = MAIN_PAN_2;
    }
    self.content.text = informListModel.msgTitle;
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

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"";
        _time.font = H14;
        _time.textColor = MAIN_PAN_2;
    }
    return _time;
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

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.text = @"";
        _content.font = H14;
        _content.textColor = MAIN_PAN_3;
    }
    return _content;
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

@end
