//
//  PendingCellView.m
//  ATT考勤
//
//  Created by Helen on 16/12/28.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "PendingCellView.h"

@interface PendingCellView()

@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UIImageView *cir;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *status;

@end

@implementation PendingCellView


#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    CGFloat length = 10;
    CGFloat Padding = 6;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(0);
        make.bottom.equalTo(0);
        make.size.equalTo(CGSizeMake(1, SCREEN_WIDTH));
    }];
    
    [self.cir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(15);
        make.centerX.equalTo(weakSelf.line);
        make.size.equalTo(CGSizeMake(length, length));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cir);
        make.left.equalTo(weakSelf.cir.mas_right).offset(10);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.time.mas_bottom).offset(Padding);
        make.left.equalTo(weakSelf.time);
    }];
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.name.mas_bottom).offset(Padding);
        make.left.equalTo(weakSelf.name);
    }];
    
    
    
    [super updateConstraints];
}


#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.line];
    [self addSubview:self.cir];
    [self addSubview:self.time];
    [self addSubview:self.name];
    [self addSubview:self.status];
 
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark loadingdata
-(void)setPendingModel:(PendingModel *)pendingModel{
    if (!pendingModel) {
        return;
    }
    _pendingModel = pendingModel;
    
    self.time.text = pendingModel.time;
    self.name.text = pendingModel.name;
    self.status.text = pendingModel.status;
}

#pragma mark lazyload
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = black_color;
    }
    return _line;
}

-(UIImageView *)cir{
    if (!_cir) {
        _cir = [[UIImageView alloc] init];
        _cir.layer.cornerRadius = 5;
        _cir.layer.masksToBounds = YES;
        _cir.layer.borderWidth = 1.0;
        _cir.layer.borderColor = MAIN_ORANGER.CGColor;
        _cir.backgroundColor = MAIN_ORANGER;
    }
    return _cir;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.textColor = MAIN_PAN_2;
        _time.font = H14;
        
    }
    return _time;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.textColor = MAIN_PAN_2;
        _name.font = H14;
    }
    return _name;
}

-(UILabel *)status{
    if (!_status) {
        _status = [[UILabel alloc] init];
        _status.textColor = MAIN_PAN_2;
        _status.font = H14;
    }
    return _status;
}
@end
