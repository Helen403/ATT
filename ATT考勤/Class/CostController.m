//
//  CostController.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CostController.h"
#import "CostView.h"
#import "CostViewModel.h"


@interface CostController ()

@property(nonatomic,strong) CostView *costView;

@property(nonatomic,strong) CostViewModel *costViewModel;

@end

@implementation CostController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.costView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"费用申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.costView];
}

-(void)h_bindViewModel{
    
    [[self.costViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:NO];
             [self.costView h_viewWillDisappear];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplyManViewRemove" object:nil];
        });
    }];
}

-(void)h_viewWillAppear{
    [self.costView h_viewWillAppear];
}

-(void)h_viewWillDisappear{
   
}

#pragma mark lazyload
-(CostView *)costView{
    if (!_costView) {
        _costView = [[CostView alloc] initWithViewModel:self.costViewModel];
    }
    return _costView;
}

-(CostViewModel *)costViewModel{
    if (!_costViewModel) {
        _costViewModel = [[CostViewModel alloc] init];
    }
    return _costViewModel;
    
}

-(void)dealloc{
    [[NSNotificationCenter  defaultCenter] removeObserver:self  name:@"ApplyManViewRemove" object:nil];
}


@end
