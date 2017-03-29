//
//  MyContrastController.m
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyContrastController.h"
#import "MyContrastView.h"
#import "MyContrastViewModel.h"

@interface MyContrastController ()

@property(nonatomic,strong) MyContrastView *myContrastView;

@property(nonatomic,strong) MyContrastViewModel *myContrastViewModel;

@end

@implementation MyContrastController

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.myContrastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"我的考勤对比";
}


-(void)h_addSubviews{
    [self.view addSubview:self.myContrastView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(MyContrastView *)myContrastView{
    if (!_myContrastView) {
        _myContrastView = [[MyContrastView alloc] initWithViewModel:self.myContrastViewModel];
    }
    return _myContrastView;
}

-(MyContrastViewModel *)myContrastViewModel{
    if (!_myContrastViewModel) {
        _myContrastViewModel = [[MyContrastViewModel alloc] init];
    }
    return _myContrastViewModel;
}



@end
