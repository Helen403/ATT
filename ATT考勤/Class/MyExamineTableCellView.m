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

@property(nonatomic,strong) UILabel *hint;

@property(nonatomic,strong) UIImageView *back;

@end


@implementation MyExamineTableCellView


#pragma mark system
-(void)updateConstraints{

    WS(weakSelf);
    [super updateConstraints];
}


#pragma mark private
-(void)h_setupViews{


    [self addSubview:self.Img];
    [self addSubview:self.title];
    [self addSubview:self.hint];
    [self addSubview:self.back];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
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
    }
    return _Img;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = H14;
        _title.textColor = MAIN_PAN;
        _title.text = @"待处理";
    }
    return _title;

}

-(UILabel *)hint{
    if (!_hint) {
        _hint = [[UILabel alloc] init];
        _hint.text = @"1";
        _hint.textColor = MAIN_PAN;
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










@end
