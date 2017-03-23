//
//  SignController.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "SignController.h"
#import "SignViewModel.h"
#import "SignView.h"

@interface SignController ()

@property(nonatomic,strong) SignViewModel *signViewModel;

@property(nonatomic,strong) SignView *signView;

@end

@implementation SignController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}
#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"签到英雄榜";
}


-(void)h_addSubviews{
    [self.view addSubview:self.signView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(SignView *)signView{
    if (!_signView) {
        _signView = [[SignView alloc] initWithViewModel:self.signViewModel];
    }
    return _signView;
}

-(SignViewModel *)signViewModel{
    if (!_signViewModel) {
        _signViewModel = [[SignViewModel alloc] init];
    }
    return _signViewModel;
}



@end
