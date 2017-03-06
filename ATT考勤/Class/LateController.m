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
#import "ChoiceStaffTeamController.h"


@interface LateController ()

@property(nonatomic,strong) LateView *lateView;

@property(nonatomic,strong) LateViewModel *lateViewModel;

@end

@implementation LateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.lateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"迟到申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.lateView];
}

-(void)h_bindViewModel{
    
    [[self.lateViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
             [self.navigationController popViewControllerAnimated:NO];
            
        });
       
    }];
}



#pragma mark lazyload
-(LateView *)lateView{
    if (!_lateView) {
        _lateView = [[LateView alloc] initWithViewModel:self.lateViewModel];
    }
    return _lateView;
}

-(LateViewModel *)lateViewModel{
    if (!_lateViewModel) {
        _lateViewModel = [[LateViewModel alloc] init];
    }
    return _lateViewModel;
    
}



@end
