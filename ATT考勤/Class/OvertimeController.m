//
//  OvertimeController.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "OvertimeController.h"
#import "OvertimeViewModel.h"
#import "OvertimeView.h"


@interface OvertimeController ()

@property(nonatomic,strong) OvertimeViewModel *overtimeViewModel;

@property(nonatomic,strong) OvertimeView *overtimeView;

@end

@implementation OvertimeController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.overtimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"加班申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.overtimeView];
}

-(void)h_bindViewModel{
    
    [[self.overtimeViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
             [self.navigationController popViewControllerAnimated:NO];
            
        });
    }];
}


#pragma mark lazyload
-(OvertimeView *)overtimeView{
    if (!_overtimeView) {
        _overtimeView = [[OvertimeView alloc] initWithViewModel:self.overtimeViewModel];
    }
    return _overtimeView;
}

-(OvertimeViewModel *)overtimeViewModel{
    if (!_overtimeViewModel) {
        _overtimeViewModel = [[OvertimeViewModel alloc] init];
    }
    return _overtimeViewModel;
    
}


@end
