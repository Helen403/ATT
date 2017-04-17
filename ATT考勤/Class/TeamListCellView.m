//
//  TeamListCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamListCellView.h"

@interface TeamListCellView()

@property(nonatomic,strong) UILabel *img;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *number;


@property(nonatomic,strong) UIView *view;

@end

@implementation TeamListCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);

    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:8]);
        make.size.equalTo(CGSizeMake([self h_w:36], [self h_w:36]));
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf.view);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.view.mas_right).offset([self h_w:10]);
    }];
    
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    [self addSubview:self.view];
    [self addSubview:self.img];
    [self addSubview:self.title];
    [self addSubview:self.number];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark dataload
-(void)setTeamListModel:(TeamListModel *)teamListModel{
    if (!teamListModel) {
        return;
    }
    _teamListModel = teamListModel;

    if ([LSCoreToolCenter PureLetters:teamListModel.empName]) {
       self.img.text = teamListModel.empName;
    }else{
        if (teamListModel.empName.length==3) {
            self.img.text = [teamListModel.empName  substringFromIndex:1];
        }else{
            self.img.text = teamListModel.empName;
        }
    }

    
    self.title.text = teamListModel.empName;
    //self.number.text = teamListModel.empTelphone;
    
}


-(void)setBgColor:(UIColor *)bgColor{
    if (!bgColor) {
        return;
    }
    _bgColor = bgColor;
    self.view.backgroundColor = bgColor;
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.view.backgroundColor = self.bgColor;
    self.img.backgroundColor = self.bgColor;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.view.backgroundColor = self.bgColor;
    self.img.backgroundColor = self.bgColor;
}


#pragma mark lazyload
-(UILabel *)img{
    if (!_img) {
        _img = [[UILabel alloc] init];
        _img.text = @"";
        _img.font = H14;
        _img.textColor = white_color;
    }
    return _img;
}

-(UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] init];
        
        ViewRadius(_view, [self h_w:18]);
    }
    return _view;
    
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

-(UILabel *)number{
    if (!_number) {
        _number = [[UILabel alloc] init];
        _number.text = @"";
        _number.font = H14;
        _number.textColor = MAIN_PAN_2;
    }
    return _number;
}


@end
