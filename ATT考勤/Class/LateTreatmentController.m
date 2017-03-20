//
//  LateTreatmentController.m
//  ATT考勤
//
//  Created by Helen on 17/3/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "LateTreatmentController.h"
#import "LateTreatmentView.h"
#import "LateTreatmentViewModel.h"
#import "ApprovalTreatmentController.h"

@interface LateTreatmentController ()

@property(nonatomic,strong) LateTreatmentView *lateTreatmentView;

@property(nonatomic,strong) LateTreatmentViewModel *lateTreatmentViewModel;

@end

@implementation LateTreatmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.lateTreatmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"待处理";
}


-(void)h_addSubviews{
    [self.view addSubview:self.lateTreatmentView];
}

-(void)h_bindViewModel{
    [[self.lateTreatmentViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
       
        
        ApprovalTreatmentController *approvalTreatement = [[ApprovalTreatmentController alloc] init];
        
        approvalTreatement.indexTmp = x.intValue;
        approvalTreatement.arr = self.lateTreatmentViewModel.arr;
        
        [self.navigationController pushViewController:approvalTreatement animated:NO];

    }];
    
}

#pragma mark lazyload
-(LateTreatmentView *)lateTreatmentView{
    if (!_lateTreatmentView) {
        _lateTreatmentView = [[LateTreatmentView alloc] initWithViewModel:self.lateTreatmentViewModel];
    }
    return _lateTreatmentView;
}

-(LateTreatmentViewModel *)lateTreatmentViewModel{
    if (!_lateTreatmentViewModel) {
        _lateTreatmentViewModel = [[LateTreatmentViewModel alloc] init];
    }
    return _lateTreatmentViewModel;
}


@end
