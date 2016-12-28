//
//  ForgetController.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ForgetController.h"
#import "ForgetView.h"
#import "ForgetViewModel.h"


#import "ForgetPwdController.h"

@interface ForgetController ()

@property(nonatomic,strong) ForgetView *forgetView;

@property(nonatomic,strong) ForgetViewModel *forgetViewModel;


@end

@implementation ForgetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark system
-(void)updateViewConstraints{

    WS(weakSelf);
    [self.forgetView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}


#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"忘记密码";

}

-(void)h_addSubviews{
    [self.view addSubview:self.forgetView];

}

-(void)h_bindViewModel{

    [[self.forgetViewModel.forgetPwdclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        ForgetPwdController *forgetPwd = [[ForgetPwdController alloc] init];
        
        [self.navigationController pushViewController:forgetPwd animated:YES];
    }];
    
}

#pragma mark lazyload
-(ForgetView *)forgetView{
    if (!_forgetView) {
        _forgetView = [[ForgetView alloc] initWithViewModel:self.forgetViewModel];
    }
    return _forgetView;
}

-(ForgetViewModel *)forgetViewModel{
    if (!_forgetViewModel) {
        _forgetViewModel = [[ForgetViewModel alloc] init];
    }
    return _forgetViewModel;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
