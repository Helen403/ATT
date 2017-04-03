//
//  BindingController.m
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "BindingController.h"
#import "BindingView.h"
#import "BindingViewModel.h"

@interface BindingController ()

@property(nonatomic,strong) BindingView *bindingView;

@property(nonatomic,strong) BindingViewModel *bindingViewModel;

@end

@implementation BindingController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.bindingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"绑定设备";
}


-(void)h_addSubviews{
    [self.view addSubview:self.bindingView];
}

-(void)h_bindViewModel{
    [[self.bindingViewModel.bindSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
}

#pragma mark lazyload
-(BindingView *)bindingView{
    if (!_bindingView) {
        _bindingView = [[BindingView alloc] initWithViewModel:self.bindingViewModel];
    }
    return _bindingView;
}

-(BindingViewModel *)bindingViewModel{
    if (!_bindingViewModel) {
        _bindingViewModel = [[BindingViewModel alloc] init];
    }
    return _bindingViewModel;
}


@end
