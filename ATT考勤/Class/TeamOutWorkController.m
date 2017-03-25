//
//  TeamOutWorkController.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamOutWorkController.h"
#import "TeamOutWorkViewModel.h"
#import "TeamOutWorkView.h"
#import "TeamOutWorkModel.h"
#import "TeamOutWorkDetailsController.h"

@interface TeamOutWorkController ()

@property(nonatomic,strong) TeamOutWorkViewModel *teamOutWorkViewModel;

@property(nonatomic,strong) TeamOutWorkView *teamOutWorkView;

@end

@implementation TeamOutWorkController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.teamOutWorkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"部门外勤统计";
}


-(void)h_addSubviews{
    [self.view addSubview:self.teamOutWorkView];
}

-(void)h_bindViewModel{
    [[self.teamOutWorkViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        TeamOutWorkModel *teamOutWorkModel = self.teamOutWorkViewModel.arr[x.intValue];
        
        TeamOutWorkDetailsController *teamOutWorkDetails = [[TeamOutWorkDetailsController alloc] init];
        
        teamOutWorkDetails.deptCode =  teamOutWorkModel.deptCode;
        teamOutWorkDetails.startDate =  teamOutWorkModel.startDate;
        teamOutWorkDetails.endDate =  teamOutWorkModel.endDate;
        [self.navigationController pushViewController:teamOutWorkDetails animated:NO];
    }];
    
}

#pragma mark lazyload
-(TeamOutWorkView *)teamOutWorkView{
    if (!_teamOutWorkView) {
        _teamOutWorkView = [[TeamOutWorkView alloc] initWithViewModel:self.teamOutWorkViewModel];
    }
    return _teamOutWorkView;
}

-(TeamOutWorkViewModel *)teamOutWorkViewModel{
    if (!_teamOutWorkViewModel) {
        _teamOutWorkViewModel = [[TeamOutWorkViewModel alloc] init];
    }
    return _teamOutWorkViewModel;
}


@end
