//
//  ResignationController.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ResignationController.h"
#import "ResignationViewModel.h"
#import "ResignationView.h"

@interface ResignationController ()

@property(nonatomic,strong) ResignationView *resignationView;

@property(nonatomic,strong) ResignationViewModel *resignationViewModel;

@end

@implementation ResignationController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}
#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.resignationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"辞职申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.resignationView];
}

-(void)h_bindViewModel{
    
    [[self.resignationViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        //        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [self.navigationController popViewControllerAnimated:NO];
    }];
    
}


#pragma mark lazyload
-(ResignationView *)resignationView{
    if (!_resignationView) {
        _resignationView = [[ResignationView alloc] initWithViewModel:self.resignationViewModel];
    }
    return _resignationView;
}

-(ResignationViewModel *)resignationViewModel{
    if (!_resignationViewModel) {
        _resignationViewModel = [[ResignationViewModel alloc] init];
    }
    return _resignationViewModel;
    
}




@end
