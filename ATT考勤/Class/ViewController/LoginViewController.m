//
//  LoginViewController.m
//  ATT考勤
//
//  Created by Helen on 16/12/16.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "LoginViewModel.h"


#import "ForgetController.h"

#import "NewpartViewController.h"

#import "XCFTabBarController.h"





@interface LoginViewController ()

@property(nonatomic,strong) LoginView *loginView;

@property(nonatomic,strong) LoginViewModel *loginViewModel;

@end

@implementation LoginViewController

#pragma mark - system
-(void)viewWillAppear:(BOOL)animated{
    
    [self hideNavigationBar:YES animated:NO];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self hideNavigationBar:NO animated:NO];
    
    [super viewWillDisappear:animated];
}



- (void)updateViewConstraints {
    
    WS(weakSelf)
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark -private
-(void)h_layoutNavigation{
  
}

-(void)h_addSubviews{
    [self.view addSubview:self.loginView];
    
   
    

}

-(void)h_bindViewModel{
    
//    @weakify(self);
    [self.loginViewModel.loginclickSubject subscribeNext:^(id x) {
//        @strongify(self);
        
        switch ([x integerValue]) {
            case HSuccess:
                [UIApplication sharedApplication].keyWindow.rootViewController =[[XCFTabBarController alloc] init];
                break;
                
            case HFailure:
                break;
        }
    }];
    
    
    @weakify(self);
    [[self.loginViewModel.forgetclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        NSLog(@"kk");
        @strongify(self);
        ForgetController *forgetController = [[ForgetController alloc] init];
        
       
////
//        [forgetController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
//        
//        [self presentViewController:forgetController animated:YES completion:^{
//            
//        }];
        
        [self.navigationController pushViewController:forgetController animated:YES];
        
    }];
    
    [[self.loginViewModel.newpartclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
    
        NewpartViewController *newpartController = [[NewpartViewController alloc] init];
        
        [self.navigationController pushViewController:newpartController animated:YES];
    }];
}

#pragma mark lazyload
-(LoginView *)loginView{
    
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithViewModel:self.loginViewModel];
    }
    return _loginView;
}

-(LoginViewModel *)loginViewModel{
    
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
