//
//  ChoiceStaffCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChoiceStaffCellView.h"

@interface ChoiceStaffCellView()

@property(nonatomic,strong) UIImageView *select;

@property(nonatomic,strong) UIView *bg;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *introduction;

@end

@implementation ChoiceStaffCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
//    [self.select mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf);
//        make.left.equalTo([self h_w:10]);
//    }];
    
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.select.mas_right).offset([self h_w:10]);
         make.left.equalTo([self h_w:45]);
        make.centerY.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake([self h_w:40], [self h_w:40]));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.bg);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bg.mas_top);
        make.left.equalTo(weakSelf.bg.mas_right).offset([self h_w:10]);
    }];
    
    [self.introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:1]);
        make.left.equalTo(weakSelf.title);
    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = white_color;
    
//    [self addSubview:self.select];
    [self addSubview:self.bg];
    [self addSubview:self.name];
    [self addSubview:self.title];
    [self addSubview:self.introduction];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setTeamListModel:(TeamListModel *)teamListModel{
    if (!teamListModel) {
        return;
    }
    _teamListModel = teamListModel;
    
    if (teamListModel.empName.length==3) {
        self.name.text = [teamListModel.empName  substringFromIndex:1];
    }else{
        self.name.text = teamListModel.empName;
    }
    
    self.title.text = teamListModel.empName;
    self.introduction.text = teamListModel.position;
    self.bg.backgroundColor = [UIColor colorWithHexString:teamListModel.empColor] ;
}


#pragma mark lazyload
-(UIImageView *)select{
    if (!_select) {
        _select = [[UIImageView alloc] init];
        _select.image = ImageNamed(@"abc_normal");
        _select.hidden = YES;
    }
    return _select;
}

-(UIView *)bg{
    if (!_bg) {
        _bg = [[UIView alloc] init];
        ViewRadius(_bg, [self h_w:20]);
    }
    return _bg;
}


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.bg.backgroundColor =[UIColor colorWithHexString:self.teamListModel.empColor] ;
    self.name.backgroundColor = [UIColor colorWithHexString:self.teamListModel.empColor] ;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
     self.bg.backgroundColor = [UIColor colorWithHexString:self.teamListModel.empColor];
    self.name.backgroundColor = [UIColor colorWithHexString:self.teamListModel.empColor];
}


-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"";
        _name.font = H12;
        _name.textColor = white_color;
        _name.backgroundColor = [UIColor colorWithHexString:self.teamListModel.empColor];
    }
    return _name;
}


-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UILabel *)introduction{
    if (!_introduction) {
        _introduction = [[UILabel alloc] init];
        _introduction.text = @"";
        _introduction.font = H12;
        _introduction.textColor = MAIN_PAN;
    }
    return _introduction;
}

@end
