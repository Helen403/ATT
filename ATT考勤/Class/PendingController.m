//
//  PendingController.m
//  ATT考勤
//
//  Created by Helen on 16/12/28.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "PendingController.h"
#import "PendingView.h"
#import "PendingViewModel.h"


@interface PendingController ()

@property(nonatomic,strong) PendingView *pendingView;

@property(nonatomic,strong) PendingViewModel *pendingViewModel;

@end

@implementation PendingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.pendingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];

    [super updateViewConstraints];
}


#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"审批的";
}

-(void)h_addSubviews{

    [self.view addSubview:self.pendingView];
}

-(void)h_bindViewModel{


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(PendingView *)pendingView{
    if (!_pendingView) {
        _pendingView = [[PendingView alloc] initWithViewModel:self.pendingViewModel];
    }
    return _pendingView;
}

-(PendingViewModel *)pendingViewModel{
    if (!_pendingViewModel) {
        _pendingViewModel = [[PendingViewModel alloc] init];
    }
    return _pendingViewModel;
}


@end
