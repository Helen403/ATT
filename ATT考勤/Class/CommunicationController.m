//
//  CommunicationController.m
//  ATT考勤
//
//  Created by Helen on 17/4/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CommunicationController.h"
#import "CommunicationView.h"
#import "CommunicationViewModel.h"
#import "TeamController.h"
#import "TeamListController.h"

@interface CommunicationController ()

@property(nonatomic,strong) CommunicationView *communicationView;

@property(nonatomic,strong) CommunicationViewModel *communicationViewModel;
@end

@implementation CommunicationController

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.communicationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"通讯录";
}


-(void)h_addSubviews{
    [self.view addSubview:self.communicationView];
}

-(void)h_bindViewModel{
    //跳转到部门通讯
    [[self.communicationViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        TeamController *team = [[TeamController alloc] init];
        
        [self.navigationController pushViewController:team animated:NO];
    }];
    
    [[self.communicationViewModel.myTeamSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        TeamListController *teamList = [[TeamListController alloc] init];
   
        NSString *deptCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"deptCode"];
         NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
        teamList.deptCode =  deptCode;
        teamList.companyCode = companyCode;
        [self.navigationController pushViewController:teamList animated:NO];
        
        
    }];
}

#pragma mark lazyload
-(CommunicationView *)communicationView{
    if (!_communicationView) {
        _communicationView = [[CommunicationView alloc] initWithViewModel:self.communicationViewModel];
    }
    return _communicationView;
}

-(CommunicationViewModel *)communicationViewModel{
    if (!_communicationViewModel) {
        _communicationViewModel = [[CommunicationViewModel alloc] init];
    }
    return _communicationViewModel;
}


@end
