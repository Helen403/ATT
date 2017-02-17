//
//  TeamController.m
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamController.h"
#import "TeamViewModel.h"
#import "TeamView.h"

#import "TeamModel.h"
#import "TeamListController.h"


@interface TeamController ()

@property(nonatomic,strong) TeamViewModel *teamViewModel;

@property(nonatomic,strong) TeamView *teamView;

@end

@implementation TeamController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    
    WS(weakSelf);
    [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}


#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"通讯录";
}

-(void)h_addSubviews{
    
    [self.view addSubview:self.teamView];
}

-(void)h_bindViewModel{
    [[self.teamViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        TeamListController *teamList = [[TeamListController alloc] init];

        TeamModel *teamModel =self.teamViewModel.arr[[x intValue]];
        
        teamList.deptCode =  teamModel.deptCode;
        teamList.companyCode = teamModel.companyCode;
        [self.navigationController pushViewController:teamList animated:NO];
        
    }];
    
    
}

#pragma mark lazyload
-(TeamView *)teamView{
    if (!_teamView) {
        _teamView = [[TeamView alloc] initWithViewModel:self.teamViewModel];
    }
    return _teamView;
}

-(TeamViewModel *)teamViewModel{
    if (!_teamViewModel) {
        _teamViewModel = [[TeamViewModel alloc] init];
    }
    return _teamViewModel;
}


@end
