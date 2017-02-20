//
//  ChangeTelphoneController.m
//  ATT考勤
//
//  Created by Helen on 17/2/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChangeTelphoneController.h"
#import "ChangeTelphoneView.h"
#import "ChangeTelphoneViewModel.h"


@interface ChangeTelphoneController ()

@property(nonatomic,strong) ChangeTelphoneView *changeTelphoneView;

@property(nonatomic,strong) ChangeTelphoneViewModel *changeTelphoneViewModel;

@end

@implementation ChangeTelphoneController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.changeTelphoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"更换手机号";
}

-(void)h_addSubviews{
    [self.view addSubview:self.changeTelphoneView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(ChangeTelphoneView *)changeTelphoneView{
    if (!_changeTelphoneView) {
        _changeTelphoneView = [[ChangeTelphoneView alloc] initWithViewModel:self.changeTelphoneViewModel];
    }
    return _changeTelphoneView;
}

-(ChangeTelphoneViewModel *)changeTelphoneViewModel{
    if (!_changeTelphoneViewModel) {
        _changeTelphoneViewModel = [[ChangeTelphoneViewModel alloc] init];
    }
    return _changeTelphoneViewModel;
}

@end
