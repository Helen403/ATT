//
//  MoveController.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MoveController.h"
#import "MoveViewModel.h"
#import "MoveView.h"

@interface MoveController ()

@property(nonatomic,strong) MoveView *moveView;

@property(nonatomic,strong) MoveViewModel *moveViewModel;

@end

@implementation MoveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.moveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"调班申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.moveView];
}

-(void)h_bindViewModel{
    
    [[self.moveViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    
}


#pragma mark lazyload
-(MoveView *)moveView{
    if (!_moveView) {
        _moveView = [[MoveView alloc] initWithViewModel:self.moveViewModel];
    }
    return _moveView;
}

-(MoveViewModel *)moveViewModel{
    if (!_moveViewModel) {
        _moveViewModel = [[MoveViewModel alloc] init];
    }
    return _moveViewModel;
    
}


@end
