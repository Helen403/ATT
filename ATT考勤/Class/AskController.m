//
//  AskController.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AskController.h"
#import "AskView.h"
#import "AskViewModel.h"

@interface AskController ()

@property(nonatomic,strong) AskView *askView;

@property(nonatomic,strong) AskViewModel *askViewModel;

@end

@implementation AskController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.askView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_addSubviews{
    [self.view addSubview:self.askView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(AskView *)askView{
    if (!_askView) {
        _askView = [[AskView alloc] initWithViewModel:self.askViewModel];
    }
    return _askView;
}


-(AskViewModel *)askViewModel{
    if (!_askViewModel) {
        _askViewModel = [[AskViewModel alloc] init];
    }
    return _askViewModel;
}


@end
