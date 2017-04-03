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

#import "ChangeTelphoneController.h"
#import "ChangePasswordController.h"
#import "BindingController.h"

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

-(void)h_viewWillAppear{
    [self.securityView h_refreash];
}

-(void)h_addSubviews{
    [self.view addSubview:self.securityView];
}

-(void)h_bindViewModel{
    [[self.securityViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        switch ([x intValue]) {
                //更换手机号
            case 0:{
                ChangeTelphoneController *changeTelphone = [[ChangeTelphoneController alloc] init];
                
                [self.navigationController pushViewController:changeTelphone animated:NO];
                break;
            }
                //修改密码
            case 1:{
                ChangePasswordController *changePassword = [[ChangePasswordController alloc] init];
                
                [self.navigationController pushViewController:changePassword animated:NO];
                break;
            }

                //绑定设备
            case 2:{
                BindingController *binding = [[BindingController alloc] init];
                
                [self.navigationController pushViewController:binding animated:NO];
                break;
            }
                
        }

    }];
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
