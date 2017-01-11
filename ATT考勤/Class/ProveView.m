//
//  ProveView.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ProveView.h"

@interface ProveView()

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIImageView *Img;

@end

@implementation ProveView

#pragma mark system
-(void)updateConstraints{
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(6);
        make.left.equalTo(10);
    }];
    
    [self.Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset(10);
        make.left.equalTo(15);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{

    [self addSubview:self.title];
    [self addSubview:self.Img];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{

}

#pragma mark lazyload
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"审批人";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UIImageView *)Img{
    if (!_Img) {
        _Img = [[UIImageView alloc] init];
        _Img.image = ImageNamed(@"role_code_icon");
    }
    return _Img;
}



@end
