//
//  MyApplyController.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "MyApplyController.h"
#import "MyApplyView.h"
#import "MyApplyViewModel.h"

#import "ApplicationController.h"

@interface MyApplyController ()

@property(nonatomic,strong) MyApplyView *myapplyView;

@property(nonatomic,strong) MyApplyViewModel *myApplyViewModel;

@end

@implementation MyApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    
    [self.myapplyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
    }];
    
    
    [super updateViewConstraints];
}


-(void)h_addSubviews{
    
    
    [self.view addSubview:self.myapplyView];
}

-(void)h_bindViewModel{
    
    [[self.myApplyViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        ApplicationController *application = [[ApplicationController alloc] init];
        
        [self.navigationController pushViewController:application animated:NO];
        
    
        NSLog(@"%@",x);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark lazyload
-(MyApplyView *)myapplyView{
    
    if (!_myapplyView) {
        _myapplyView = [[MyApplyView alloc] initWithViewModel:self.myApplyViewModel];
    }
    return _myapplyView;
}


-(MyApplyViewModel *)myApplyViewModel{
    if (!_myApplyViewModel) {
        _myApplyViewModel = [[MyApplyViewModel alloc] init];
    }
    return _myApplyViewModel;
}


@end
