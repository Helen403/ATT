//
//  GoOutController.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "GoOutController.h"
#import "GoOutView.h"
#import "GoOutViewModel.h"

@interface GoOutController ()

@property(nonatomic,strong) GoOutView *goOutView;

@property(nonatomic,strong) GoOutViewModel *goOutViewModel;

@end

@implementation GoOutController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.goOutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"外出申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.goOutView];
}

-(void)h_bindViewModel{
    
    [[self.goOutViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:NO];
            
        });

    }];
    
}


#pragma mark lazyload
-(GoOutView *)goOutView{
    if (!_goOutView) {
        _goOutView = [[GoOutView alloc] initWithViewModel:self.goOutViewModel];
    }
    return _goOutView;
}

-(GoOutViewModel *)goOutViewModel{
    if (!_goOutViewModel) {
        _goOutViewModel = [[GoOutViewModel alloc] init];
    }
    return _goOutViewModel;
    
}



@end
