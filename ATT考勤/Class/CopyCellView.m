//
//  CopyCellView.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CopyCellView.h"


@interface CopyCellView()

@property(nonatomic,strong) UIView *bgView;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *result;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UIView *line;

@end

@implementation CopyCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
        make.size.equalTo(CGSizeMake([self h_w:44], [self h_w:44]));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bgView);
        make.centerX.equalTo(weakSelf.bgView);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView);
        make.left.equalTo(weakSelf.bgView.mas_right).offset([self h_w:10]);
    }];
    
    [self.result mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.back.mas_left).offset(-[self h_w:10]);
    }];
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.bgView];
    [self addSubview:self.name];
    [self addSubview:self.title];
    [self addSubview:self.time];
    [self addSubview:self.back];
    [self addSubview:self.result];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark dataload
-(void)setToMeModel:(CopyToMeModel *)toMeModel{
    if (!toMeModel) {
        return;
    }
    _toMeModel = toMeModel;
    if ([LSCoreToolCenter PureLetters:toMeModel.userName]) {
        self.name.text = toMeModel.userName;
    }else{
        if (toMeModel.userName.length==3) {
            self.name.text = [toMeModel.userName  substringFromIndex:1];
        }else{
            self.name.text = toMeModel.userName;
        }
    }
    
    self.title.text = toMeModel.applyDateDesc;
    self.result.text = [NSString stringWithFormat:@"%@ %@",toMeModel.applyType,toMeModel.applyMsg] ;
    
    self.bgView.backgroundColor =[UIColor colorWithHexString:toMeModel.empColor] ;
}



-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.bgView.backgroundColor =[UIColor colorWithHexString:self.toMeModel.empColor] ;
    self.name.backgroundColor =[UIColor colorWithHexString:self.toMeModel.empColor] ;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.bgView.backgroundColor =[UIColor colorWithHexString:self.toMeModel.empColor] ;
    self.name.backgroundColor =[UIColor colorWithHexString:self.toMeModel.empColor] ;
}


#pragma mark lazyload
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        ViewRadius(_bgView, [self h_w:22]);
    }
    return _bgView;
}


-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"";
        _name.font = H14;
        _name.textColor = white_color;
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


-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"";
        _time.font = H14;
        _time.textColor = MAIN_PAN_2;
    }
    return _time;
}

-(UIImageView *)back{
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = ImageNamed(@"role_right_arrow");
    }
    return _back;
}

-(UILabel *)result{
    if (!_result) {
        _result = [[UILabel alloc] init];
        _result.text = @"";
        _result.font = H14;
        _result.textColor = MAIN_PAN_3;
    }
    return _result;
}


-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

@end
