//
//  EmployeeCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/10.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "EmployeeCellView.h"

@interface EmployeeCellView()

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *content;

@property(nonatomic,strong) UIImageView *show;

@property(nonatomic,strong) UIView *line;

@end

@implementation EmployeeCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.title.mas_right).offset([self h_w:10]);
    }];
    
    [self.show mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.content];
    [self addSubview:self.show];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setEmployeeModel:(EmployeeModel *)employeeModel{
    if (!employeeModel) {
        return;
    }
    _employeeModel = employeeModel;
    self.title.text = employeeModel.title;
    self.content.text = employeeModel.content;
    self.show.image = ImageNamed(employeeModel.show);
}

#pragma mark lazyload
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"反馈类型";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.text = @"反馈类型";
        _content.font = H14;
        _content.textColor = MAIN_PAN_2;
    }
    return _content;
}

-(UIImageView *)show{
    if (!_show) {
        _show = [[UIImageView alloc] init];
    }
    return _show;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

@end
