//
//  MyTrajectoryController.m
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyTrajectoryController.h"
#import "MyTrajectoryView.h"
#import "MyTrajectoryViewModel.h"


@interface MyTrajectoryController ()

@property(nonatomic,strong) MyTrajectoryView *myTrajectoryView;

@property(nonatomic,strong) MyTrajectoryViewModel *myTrajectoryViewModel;

@end

@implementation MyTrajectoryController

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.myTrajectoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"我的考勤轨迹";
}


-(void)h_addSubviews{
    [self.view addSubview:self.myTrajectoryView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(MyTrajectoryView *)myTrajectoryView{
    if (!_myTrajectoryView) {
        _myTrajectoryView = [[MyTrajectoryView alloc] initWithViewModel:self.myTrajectoryViewModel];
    }
    return _myTrajectoryView;
}

-(MyTrajectoryViewModel *)myTrajectoryViewModel{
    if (!_myTrajectoryViewModel) {
        _myTrajectoryViewModel = [[MyTrajectoryViewModel alloc] init];
    }
    return _myTrajectoryViewModel;
}

@end
