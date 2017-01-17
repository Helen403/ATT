//
//  DrainPunchController.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DrainPunchController.h"
#import "DrainPunchViewModel.h"
#import "DrainPunchView.h"


@interface DrainPunchController ()

@property(nonatomic,strong) DrainPunchViewModel *drainPunchViewModel;

@property(nonatomic,strong) DrainPunchView *drainPunchView;

@end

@implementation DrainPunchController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.drainPunchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"漏打卡申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.drainPunchView];
}

-(void)h_bindViewModel{
    
    [[self.drainPunchViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        //        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [self.navigationController popViewControllerAnimated:NO];
    }];
    
}


#pragma mark lazyload
-(DrainPunchView *)drainPunchView{
    if (!_drainPunchView) {
        _drainPunchView = [[DrainPunchView alloc] initWithViewModel:self.drainPunchViewModel];
    }
    return _drainPunchView;
}

-(DrainPunchViewModel *)drainPunchViewModel{
    if (!_drainPunchViewModel) {
        _drainPunchViewModel = [[DrainPunchViewModel alloc] init];
    }
    return _drainPunchViewModel;
    
}


@end
