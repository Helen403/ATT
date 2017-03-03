//
//  ApplyManCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ApplyManCellView.h"


@interface ApplyManCellView()



@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UIView *bg;

@end

@implementation ApplyManCellView

#pragma mark system

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake([self h_w:40], [self h_w:40]));
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{

//    self.backgroundColor = purple_color;
    [self addSubview:self.bg];
    [self addSubview:self.name];
    
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

    self.bg.backgroundColor = randomColorA;
}

#pragma mark lazyload
-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"";
        _name.font = H14;
        _name.textColor = white_color;
    }
    return _name;
}

-(UIView *)bg{
    if (!_bg) {
        _bg = [[UIView alloc] init];
        _bg.backgroundColor = randomColorA;
        ViewRadius(_bg, [self h_w:20]);
    }
    return _bg;
}


@end
