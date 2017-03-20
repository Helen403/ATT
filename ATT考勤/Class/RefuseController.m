//
//  RefuseController.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "RefuseController.h"
#import "RefuseView.h"
#import "RefuseViewModel.h"
#import "RefuseDetailsController.h"

@interface RefuseController ()

@property(nonatomic,strong) RefuseView *refuseView;

@property(nonatomic,strong) RefuseViewModel *refuseViewModel;

@end

@implementation RefuseController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.refuseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"已拒绝";
}


-(void)h_addSubviews{
    [self.view addSubview:self.refuseView];
}

-(void)h_bindViewModel{
    [[self.refuseViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        RefuseDetailsController *refuseDetails = [[RefuseDetailsController alloc] init];
        
        refuseDetails.indexTmp = x.intValue;
        refuseDetails.arr = self.refuseViewModel.arr;
        
        [self.navigationController pushViewController:refuseDetails animated:NO];
        
    }];
}

#pragma mark lazyload
-(RefuseView *)refuseView{
    if (!_refuseView) {
        _refuseView = [[RefuseView alloc] initWithViewModel:self.refuseViewModel];
    }
    return _refuseView;
}

-(RefuseViewModel *)refuseViewModel{
    if (!_refuseViewModel) {
        _refuseViewModel = [[RefuseViewModel alloc] init];
    }
    return _refuseViewModel;

}





@end
