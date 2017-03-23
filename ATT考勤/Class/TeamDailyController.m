//
//  TeamDailyController.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamDailyController.h"
#import "TeamDailyView.h"
#import "TeamDailyViewModel.h"
#import "TeamDailyDetailsController.h"
#import "TeamDailyModel.h"

@interface TeamDailyController ()

@property(nonatomic,strong) TeamDailyView *teamDailyView;

@property(nonatomic,strong) TeamDailyViewModel *teamDailyViewModel;

@end

@implementation TeamDailyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.teamDailyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"部门日报";
}


-(void)h_addSubviews{
    [self.view addSubview:self.teamDailyView];
}

-(void)h_bindViewModel{
    [[self.teamDailyViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        
        TeamDailyModel *teamDailyModel = self.teamDailyViewModel.arr[x.intValue];
        
        TeamDailyDetailsController *teamDailyDetails = [[TeamDailyDetailsController alloc] init];
        teamDailyDetails.deptName = teamDailyModel.deptName;
        teamDailyDetails.deptCode =  teamDailyModel.deptCode;
        teamDailyDetails.cardDate =  teamDailyModel.busDate;
        [self.navigationController pushViewController:teamDailyDetails animated:NO];
        
        
        
    }];
}

#pragma mark lazyload
-(TeamDailyView *)teamDailyView{
    if (!_teamDailyView) {
        _teamDailyView = [[TeamDailyView alloc] initWithViewModel:self.teamDailyViewModel];
    }
    return _teamDailyView;
}

-(TeamDailyViewModel *)teamDailyViewModel{
    if (!_teamDailyViewModel) {
        _teamDailyViewModel = [[TeamDailyViewModel alloc] init];
    }
    return _teamDailyViewModel;
}



@end
