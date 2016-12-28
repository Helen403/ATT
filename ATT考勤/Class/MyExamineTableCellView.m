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





@end
