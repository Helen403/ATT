//
//  ApproveController.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ApproveController.h"
#import "ApproveView.h"
#import "ApproveViewModel.h"

@interface ApproveController ()

@property(nonatomic,strong) ApproveView *approveView;

@property(nonatomic,strong) ApproveViewModel *approveViewModel;

@end

@implementation ApproveController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.approveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}



-(void)h_addSubviews{
    [self.view addSubview:self.approveView];
}

-(void)h_bindViewModel{
    
    
}
#pragma mark lazyload
-(ApproveView *)approveView{
    if (!_approveView) {
        _approveView = [[ApproveView alloc] initWithViewModel:self.approveViewModel];
    }
    return _approveView;
}

-(ApproveViewModel *)approveViewModel{
    if (!_approveViewModel) {
        _approveViewModel = [[ApproveViewModel alloc] init];
    }
    return _approveViewModel;
}


@end
