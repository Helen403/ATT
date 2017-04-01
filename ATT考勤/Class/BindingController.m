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
    self.title = @"部门考勤";
}


-(void)h_addSubviews{
    [self.view addSubview:self.bindingView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload




@end
