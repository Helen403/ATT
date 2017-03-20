//
//  AlreadyTreatmentController.m
//  ATT考勤
//
//  Created by Helen on 17/3/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AlreadyTreatmentController.h"
#import "AlreadyTreatmentViewModel.h"
#import "AlreadyTreatmentView.h"
#import "AlreadyDetailsController.h"

@interface AlreadyTreatmentController ()

@property(nonatomic,strong) AlreadyTreatmentViewModel *alreadyTreatmentViewModel;

@property(nonatomic,strong) AlreadyTreatmentView *alreadyTreatmentView;

@end

@implementation AlreadyTreatmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.alreadyTreatmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"已处理";
}


-(void)h_addSubviews{
    [self.view addSubview:self.alreadyTreatmentView];
}

-(void)h_bindViewModel{
    [[self.alreadyTreatmentViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {

        AlreadyDetailsController *alreadyDetails = [[AlreadyDetailsController alloc] init];
        
        alreadyDetails.indexTmp = x.intValue;
        alreadyDetails.arr = self.alreadyTreatmentViewModel.arr;
        
        [self.navigationController pushViewController:alreadyDetails animated:NO];
        
    }];
}

#pragma mark lazyload
-(AlreadyTreatmentView *)alreadyTreatmentView{
    if (!_alreadyTreatmentView) {
        _alreadyTreatmentView = [[AlreadyTreatmentView alloc] initWithViewModel:self.alreadyTreatmentViewModel];
    }
    return _alreadyTreatmentView;
}


-(AlreadyTreatmentViewModel *)alreadyTreatmentViewModel{
    if (!_alreadyTreatmentViewModel) {
        _alreadyTreatmentViewModel = [[AlreadyTreatmentViewModel alloc] init];
    }
    return _alreadyTreatmentViewModel;
}


@end
