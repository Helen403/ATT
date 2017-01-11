//
//  PersonalCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "PersonalCellView.h"

@interface PersonalCellView()

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *number;

@property(nonatomic,strong) UIImageView *back;

@end

@implementation PersonalCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.back.mas_left).offset(-[self h_w:10]);
    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    
    [self addSubview:self.title];
    [self addSubview:self.back];
    [self addSubview:self.number];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setPersonalModel:(PersonalModel *)personalModel{
    if (!personalModel) {
        return;
    }
    _personalModel = personalModel;
    self.title.text = personalModel.title;
    self.number.text = personalModel.number;

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

-(UILabel *)number{
    if (!_number) {
        _number = [[UILabel alloc] init];
        _number.text = @"反馈类型";
        _number.font = H14;
        _number.textColor = MAIN_PAN_2;
    }
    return _number;
}


-(UIImageView *)back{
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = ImageNamed(@"role_right_arrow");
    }
    return _back;
}


@end
