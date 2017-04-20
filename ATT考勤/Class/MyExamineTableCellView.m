//
//  MyExamineTableCellView.m
//  ATT考勤
//
//  Created by Helen on 16/12/28.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "MyExamineTableCellView.h"
#import "MyExamineCellViewModel.h"

@interface MyExamineTableCellView()

@property(nonatomic,strong) MyExamineCellViewModel *myExamineCellViewModel;

@property(nonatomic,strong) UIImageView *Img;

@property(nonatomic,strong) UILabel *title;



@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UIView *line;

@end


@implementation MyExamineTableCellView


#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.Img.mas_right).offset([self h_w:10]);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [self.hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.back.mas_left).offset(-[self h_w:10]);
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
    
    
    [self addSubview:self.Img];
    [self addSubview:self.title];
    [self addSubview:self.hint];
    [self addSubview:self.back];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark loaddata
-(void)setMyExamineModel:(MyExamineModel *)myExamineModel{
    if (!myExamineModel) {
        return;
    }
    _myExamineModel = myExamineModel;
    
    self.Img.image = ImageNamed(myExamineModel.Img);
    self.title.text = myExamineModel.title;
    self.hint.text = myExamineModel.hint;
}


#pragma mark lazyload
-(MyExamineCellViewModel *)myExamineCellViewModel{
    if (!_myExamineCellViewModel) {
        _myExamineCellViewModel = [[MyExamineCellViewModel alloc] init];
    }
    return _myExamineCellViewModel;
    
}

-(UIImageView *)Img{
    if (!_Img) {
        _Img = [[UIImageView alloc] init];
        _Img.image = ImageNamed(@"role_code_icon");
    }
    return _Img;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
        _title.text = @"待处理";
    }
    return _title;
    
}

-(UILabel *)hint{
    if (!_hint) {
        _hint = [[UILabel alloc] init];
        _hint.text = @"0";
        _hint.textColor = MAIN_PAN_2;
        _hint.font = H14;
    }
    return _hint;
}

-(UIImageView *)back{
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = ImageNamed(@"role_right_arrow");
    }
    return _back;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BG_COLOR;
    }
    return _line;
}


@end
