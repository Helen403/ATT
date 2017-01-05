//
//  MineController.m
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MineController.h"
#import "MineView.h"
#import "MineViewModel.h"

@interface MineController ()

@property(nonatomic,strong) MineView *mineView;

@property(nonatomic,strong) MineViewModel *mineViewModel;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.mineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}


#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"我的信息";
}

-(void)h_addSubviews{
    [self.view addSubview:self.mineView];
}

-(void)h_bindViewModel{

}


#pragma mark lazyload
-(MineView *)mineView{
    if (!_mineView) {
        _mineView = [[MineView alloc] initWithViewModel:self.mineViewModel];
    }
    return _mineView;
}


-(MineViewModel *)mineViewModel{
    if (!_mineViewModel) {
        _mineViewModel = [[MineViewModel alloc] init];
    }
    return _mineViewModel;

}

@end
