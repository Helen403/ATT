//
//  MyOpinionController.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyOpinionController.h"
#import "MyOpinionView.h"
#import "MyOpinionViewModel.h"


@interface MyOpinionController ()

@property(nonatomic,strong) MyOpinionView *myOpinionView;

@property(nonatomic,strong) MyOpinionViewModel *myOpinionViewModel;

@end

@implementation MyOpinionController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{

    WS(weakSelf);
    [self.myOpinionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_addSubviews{
    [self.view addSubview:self.myOpinionView];

}

-(void)h_bindViewModel{

}

-(void)h_viewWillAppear{
    [self.myOpinionView h_refreash];

}


#pragma mark lazyload
-(MyOpinionView *)myOpinionView{
    if (!_myOpinionView) {
        _myOpinionView = [[MyOpinionView alloc] initWithViewModel:self.myOpinionViewModel];
    }
    return _myOpinionView;
}

-(MyOpinionViewModel *)myOpinionViewModel{
    if (!_myOpinionViewModel) {
        _myOpinionViewModel = [[MyOpinionViewModel alloc] init];
    }
    return _myOpinionViewModel;

}


@end
