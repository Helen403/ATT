//
//  ApplicationController.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ApplicationController.h"
#import "ApplicationView.h"
#import "ApplicationViewModel.h"


@interface ApplicationController ()

@property(nonatomic,strong) ApplicationView *applicationView;

@property(nonatomic,strong) ApplicationViewModel *applicationViewModel;

@end

@implementation ApplicationController

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
        
        
        
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];

}


#pragma mark lazyload
-(ApplicationView *)applicationView{
    if (!_applicationView) {
        _applicationView = [[ApplicationView alloc] initWithViewModel:self.applicationViewModel];
    }
    return _applicationView;
}

-(ApplicationViewModel *)applicationViewModel{
    if (!_applicationViewModel) {
        _applicationViewModel = [[ApplicationViewModel alloc] init];
    }
    return _applicationViewModel;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
