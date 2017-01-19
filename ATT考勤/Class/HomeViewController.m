//
//  HomeViewController.m
//  ATT考勤
//
//  Created by Helen on 16/12/21.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "HomeViewModel.h"

#import "MineController.h"
#import "SetController.h"



@interface HomeViewController ()

@property(nonatomic,strong) HomeView *homeView;

@property(nonatomic,strong) HomeViewModel *homeViewModel;



@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [self hideNavigationBar:YES animated:NO];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self hideNavigationBar:NO animated:NO];
    
    [super viewWillDisappear:animated];
}


-(void)viewDidLoad{
    [super viewDidLoad];
   
}




#pragma mark system
-(void)updateViewConstraints{
    
    WS(weakSelf);
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_addSubviews{
    [self.view addSubview:self.homeView];
}

-(void)h_bindViewModel{
    //跳转到个人信息
    [[self.homeViewModel.headclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        MineController *mine = [[MineController alloc] init];
        [self.navigationController pushViewController:mine animated:NO];
    }];
    
    //跳转到设置
    [[self.homeViewModel.setClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        SetController *set = [[SetController alloc] init];
        [self.navigationController pushViewController:set animated:NO];
    }];
    
  
    
    
}


#pragma mark lazyload
-(HomeView *)homeView{
    
    if (!_homeView) {
        _homeView = [[HomeView alloc] initWithViewModel:self.homeViewModel];
    }
    
    return _homeView;
}

-(HomeViewModel *)homeViewModel{
    
    if (!_homeViewModel) {
        _homeViewModel = [[HomeViewModel alloc] init];
    }
    return _homeViewModel;
}


@end
