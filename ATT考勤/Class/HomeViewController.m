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
