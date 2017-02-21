//
//  ChangePasswordController.m
//  ATT考勤
//
//  Created by Helen on 17/2/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChangePasswordController.h"
#import "ChangePasswordView.h"
#import "ChangePasswordViewModel.h"


@interface ChangePasswordController ()

@property(nonatomic,strong)  ChangePasswordView *changePasswordView;

@property(nonatomic,strong) ChangePasswordViewModel *changePasswordViewModel;

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.changePasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"修改密码";
}


-(void)h_addSubviews{
    [self.view addSubview:self.changePasswordView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(ChangePasswordView *)changePasswordView{
    if (!_changePasswordView) {
        _changePasswordView = [[ChangePasswordView alloc] initWithViewModel:self.changePasswordViewModel];
    }
    return _changePasswordView;
}

-(ChangePasswordViewModel *)changePasswordViewModel{
    if (!_changePasswordViewModel) {
        _changePasswordViewModel = [[ChangePasswordViewModel alloc] init];
    }
    return _changePasswordViewModel;
}



@end
