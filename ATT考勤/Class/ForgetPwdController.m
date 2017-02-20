//
//  ForgetPwdController.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ForgetPwdController.h"
#import "ForgetPwdViewModel.h"
#import "ForgetPwdView.h"


@interface ForgetPwdController ()

@property(nonatomic,strong) ForgetPwdViewModel *forgetPwdViewModel;

@property(nonatomic,strong) ForgetPwdView *forgetPwdView;

@end

@implementation ForgetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{

    
    WS(weakSelf);
    [self.forgetPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    
    [super updateViewConstraints];
}


#pragma mark private
-(void)h_layoutNavigation{

    self.title = @"忘记密码";
}


-(void)h_addSubviews{
    [self.view addSubview:self.forgetPwdView];

}

-(void)h_bindViewModel{

    [[self.forgetPwdViewModel.finishclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {

          [self performSelectorOnMainThread:@selector(pop) withObject:nil waitUntilDone:YES];
    }];

}
-(void)pop{
    [self.navigationController popToRootViewControllerAnimated:YES];
    ShowMessage(@"修改成功");

}


#pragma mark lazyload
-(ForgetPwdView *)forgetPwdView{
    if (!_forgetPwdView) {
        _forgetPwdView = [[ForgetPwdView alloc] initWithViewModel:self.forgetPwdViewModel];
    }
    return _forgetPwdView;

}

-(ForgetPwdViewModel *)forgetPwdViewModel{
    if (!_forgetPwdViewModel) {
        _forgetPwdViewModel = [[ForgetPwdViewModel alloc] init];
    }
    return _forgetPwdViewModel;
}


@end
