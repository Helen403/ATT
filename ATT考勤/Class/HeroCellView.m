//
//  HeroCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HeroCellView.h"
#import "UIColor+YXAdd.h"


@interface HeroCellView()

@property(nonatomic,strong) UILabel *img;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *rank;

@property(nonatomic,strong) UIView *view;

@property(nonatomic,strong) UILabel *number;

@property(nonatomic,strong) UIView *line;

@end

@implementation HeroCellView


#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf.img);
        make.size.equalTo(CGSizeMake([self h_w:36], [self h_w:36]));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.img.mas_right).offset([self h_w:10]);
    }];
    
    [self.rank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.title);
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:6]);
    }];
    
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    [self addSubview:self.view];
    [self addSubview:self.img];
    [self addSubview:self.title];
    [self addSubview:self.rank];
    [self addSubview:self.number];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark dataload
-(void)setHeroModel:(HeroModel *)heroModel{
    if (!heroModel) {
        return;
    }
    _heroModel = heroModel;
    
    if ([LSCoreToolCenter PureLetters:heroModel.empName]) {
        self.img.text = heroModel.empName;
    }else{
        if (heroModel.empName.length==3) {
            self.img.text = [heroModel.empName  substringFromIndex:1];
        }else{
            self.img.text = heroModel.empName;
        }
    }
    
    self.title.text = heroModel.empName;
    self.number.text =[NSString stringWithFormat:@"%.2f小时",heroModel.workHours.floatValue] ;
    self.view.backgroundColor =[UIColor colorWithHexString:heroModel.empColor] ;
    self.rank.text = [NSString stringWithFormat:@"第%ld名",(long)self.index+1];
    if (self.index==0||self.index==1||self.index==2) {
        self.title.textColor = MAIN_RED;
        self.number.textColor = MAIN_RED;
        self.rank.textColor = MAIN_RED;
    }else{
        self.title.textColor = MAIN_PAN_2;
        self.number.textColor = MAIN_PAN_2;
        self.rank.textColor = MAIN_PAN_2;
    }
    
}



-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.view.backgroundColor =[UIColor colorWithHexString:self.heroModel.empColor] ;
    self.img.backgroundColor =[UIColor colorWithHexString:self.heroModel.empColor] ;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.view.backgroundColor =[UIColor colorWithHexString:self.heroModel.empColor] ;
    self.img.backgroundColor =[UIColor colorWithHexString:self.heroModel.empColor] ;
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

-(UILabel *)rank{
    if (!_rank) {
        _rank = [[UILabel alloc] init];
        _rank.text = @"";
        _rank.font = H12;
        _rank.textColor = MAIN_PAN_2;
    }
    return _rank;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}


@end
