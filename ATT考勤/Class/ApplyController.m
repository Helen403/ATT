//
//  ResignationController.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ApplyController.h"
#import "ApplyViewModel.h"
#import "ApplyView.h"


#import "MyApplyController.h"
#import "MyExamineController.h"

@interface ApplyController ()

@property(nonatomic,strong) ApplyViewModel *applyViewModel;

@property(nonatomic,strong) ApplyView *applyView;

@end

@implementation ApplyController

-(void)viewWillAppear:(BOOL)animated{
    
    //    [self hideNavigationBar:YES animated:NO];
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    //    [self hideNavigationBar:NO animated:NO];
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    //移除TabBarController自带的下部的条
    [self.tabBar removeFromSuperview];
    
   
    
    [self h_addSubviews];
    [self h_bindViewModel];
}

#pragma mark system
-(void)updateViewConstraints{
    
//    WS(weakSelf);
    [self.applyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_addSubviews{
    [self.view addSubview:self.applyView];
    
    MyApplyController *myApply = [[MyApplyController alloc] init];
    
    [self addChildViewController:myApply];
    
    MyExamineController *myExamine = [[MyExamineController alloc] init];
    
    [self addChildViewController:myExamine];

    self.selectedIndex = 0;
}

-(void)h_bindViewModel{
    
    [[self.applyViewModel.myApplyclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        self.selectedIndex = 0;
    }];
    
    [[self.applyViewModel.myExamineclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        self.selectedIndex = 1;
    }];
    
 



}


#pragma mark lazyload
-(ApplyView *)applyView{
    if (!_applyView) {
        _applyView = [[ApplyView alloc] initWithViewModel:self.applyViewModel];
    }
    return _applyView;
}

-(ApplyViewModel *)applyViewModel{
    if (!_applyViewModel) {
        _applyViewModel = [[ApplyViewModel alloc] init];
    }
    return _applyViewModel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
