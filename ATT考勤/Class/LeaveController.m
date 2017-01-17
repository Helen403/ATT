//
//  LeaveController.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "LeaveController.h"
#import "LeaveViewModel.h"
#import "LeaveView.h"

@interface LeaveController ()

@property(nonatomic,strong) LeaveView *leaveView;

@property(nonatomic,strong) LeaveViewModel *leaveViewModel;

@end

@implementation LeaveController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.leaveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"请假申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.leaveView];
}

-(void)h_bindViewModel{
    
    [[self.leaveViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        //        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [self.navigationController popViewControllerAnimated:NO];
    }];
    
}


#pragma mark lazyload
-(LeaveView *)leaveView{
    if (!_leaveView) {
        _leaveView = [[LeaveView alloc] initWithViewModel:self.leaveViewModel];
    }
    return _leaveView;
}

-(LeaveViewModel *)leaveViewModel{
    if (!_leaveViewModel) {
        _leaveViewModel = [[LeaveViewModel alloc] init];
    }
    return _leaveViewModel;
    
}



@end
