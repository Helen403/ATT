//
//  LeaveEarlyController.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "LeaveEarlyController.h"
#import "LeaveEarlyViewModel.h"
#import "LeaveEarlyView.h"

@interface LeaveEarlyController ()

@property(nonatomic,strong) LeaveEarlyViewModel *leaveEarlyViewModel;

@property(nonatomic,strong) LeaveEarlyView *leaveEarlyView;

@end

@implementation LeaveEarlyController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.leaveEarlyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"销早退申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.leaveEarlyView];
}

-(void)h_bindViewModel{
    
    [[self.leaveEarlyViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    
}


#pragma mark lazyload
-(LeaveEarlyView *)leaveEarlyView{
    if (!_leaveEarlyView) {
        _leaveEarlyView = [[LeaveEarlyView alloc] initWithViewModel:self.leaveEarlyViewModel];
    }
    return _leaveEarlyView;
}

-(LeaveEarlyViewModel *)leaveEarlyViewModel{
    if (!_leaveEarlyViewModel) {
        _leaveEarlyViewModel = [[LeaveEarlyViewModel alloc] init];
    }
    return _leaveEarlyViewModel;
    
}



@end
