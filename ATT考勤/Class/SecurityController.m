//
//  SecurityController.m
//  ATT考勤
//
//  Created by Helen on 17/1/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "SecurityController.h"
#import "SecurityView.h"
#import "SecurityViewModel.h"

@interface SecurityController ()

@property(nonatomic,strong) SecurityView *securityView;

@property(nonatomic,strong) SecurityViewModel *securityViewModel;

@end

@implementation SecurityController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.securityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"账户与安全";
}


-(void)h_addSubviews{
    [self.view addSubview:self.securityView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(SecurityView *)securityView{
    if (!_securityView) {
        _securityView = [[SecurityView alloc] initWithViewModel:self.securityViewModel];
    }
    return _securityView;
}

-(SecurityViewModel *)securityViewModel{
    if (!_securityViewModel) {
        _securityViewModel = [[SecurityViewModel alloc] init];
    }
    return _securityViewModel;
}

@end
