//
//  ApplicationController.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "LateController.h"
#import "LateView.h"
#import "LateViewModel.h"


@interface LateController ()

@property(nonatomic,strong) LateView *applicationView;

@property(nonatomic,strong) LateViewModel *applicationViewModel;

@end

@implementation LateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.applicationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];

}

#pragma mark private
-(void)h_layoutNavigation{

    self.title = @"迟到申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.applicationView];
}

-(void)h_bindViewModel{

    [[self.applicationViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {

//        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [self.navigationController popViewControllerAnimated:NO];
    }];

}


#pragma mark lazyload
-(LateView *)applicationView{
    if (!_applicationView) {
        _applicationView = [[LateView alloc] initWithViewModel:self.applicationViewModel];
    }
    return _applicationView;
}

-(LateViewModel *)applicationViewModel{
    if (!_applicationViewModel) {
        _applicationViewModel = [[LateViewModel alloc] init];
    }
    return _applicationViewModel;

}



@end
