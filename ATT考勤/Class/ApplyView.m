//
//  ResignationView.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ApplyView.h"
#import "ApplyViewModel.h"
#import "ApplyView.h"



@interface ApplyView ()

@property(nonatomic,strong) ApplyViewModel *applyViewModel;

@property(nonatomic,strong) UIButton *myApply;

@property(nonatomic,strong) UIButton *myExamine;


@end
@implementation ApplyView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.applyViewModel = (ApplyViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    
    CGFloat center = SCREEN_WIDTH*0.5;
    [self.myApply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake(center,30));
    }];
    
    [self.myExamine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.myApply.mas_right).offset(0);
        make.top.equalTo(weakSelf.myApply);
        make.size.equalTo(CGSizeMake(center,30));
    }];
    
    
    [super updateConstraints];
}


#pragma mark private
-(void)h_setupViews{
    
    
    [self addSubview:self.myApply];
    [self addSubview:self.myExamine];
    //    [self addSubview:self.view];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    
    
}


#pragma lazyload
-(ApplyViewModel *)applyViewModel{
    if (!_applyViewModel) {
        _applyViewModel = [[ApplyViewModel alloc] init];
    }
    return _applyViewModel;
}

-(UIButton *)myApply{
    if (!_myApply) {
        _myApply = [[UIButton alloc] init];
        [_myApply setTitle:@"我申请的" forState:UIControlStateNormal];
        _myApply.titleLabel.font = H14;
        _myApply.userInteractionEnabled = YES;
        [_myApply setTitleColor:MAIN_PAN forState:UIControlStateNormal];
        [_myApply setBackgroundColor:white_color];
        [_myApply addTarget:self action:@selector(apply:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myApply;
}

-(void)apply:(UIButton *)button{
    
    [self.applyViewModel.myApplyclickSubject sendNext:nil];
}

-(UIButton *)myExamine{
    if (!_myExamine) {
        _myExamine = [[UIButton alloc] init];
        [_myExamine setTitle:@"我审批的" forState:UIControlStateNormal];
        _myExamine.titleLabel.font = H14;
        
        [_myExamine setTitleColor:MAIN_PAN forState:UIControlStateNormal];
        _myExamine.userInteractionEnabled = YES;
        [_myExamine setBackgroundColor:white_color];
        [_myExamine addTarget:self action:@selector(examine:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myExamine;
}

-(void)examine:(UIButton *)button{
    
    [self.applyViewModel.myExamineclickSubject sendNext:nil];
}


@end
