//
//  OffCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "OffCellView.h"

@interface OffCellView()

@property(nonatomic,strong) UILabel *title;

@end

@implementation OffCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark dataload
-(void)setOffModel:(OffModel *)offModel{
    if (!offModel) {
        return;
    }
    _offModel = offModel;
    self.title.text = offModel.workName;
    
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

@end
