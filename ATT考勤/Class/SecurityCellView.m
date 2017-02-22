//
//  SecurityCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "SecurityCellView.h"


@interface SecurityCellView()

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *content;

@property(nonatomic,strong) UIImageView *back;

@end


@implementation SecurityCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.back.mas_left).offset(-[self h_w:10]);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.back];
    [self addSubview:self.content];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)setTelphone{
    
}


#pragma mark dataload
-(void)setSecurityModel:(SecurityModel *)securityModel{
    if (!securityModel) {
        return;
    }
    _securityModel = securityModel;
    self.title.text = securityModel.title;
    
    if (self.index == 0) {
        NSString *empTelphone =  [[NSUserDefaults standardUserDefaults] objectForKey:@"empTelphone"];
        self.content.text = empTelphone;
    }else{
        self.content.text = securityModel.content;
    }
    
    
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

-(UIImageView *)back{
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = ImageNamed(@"role_right_arrow");
    }
    return _back;
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

@end
