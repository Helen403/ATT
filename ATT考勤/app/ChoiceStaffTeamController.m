//
//  ChoiceStaffController.m
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChoiceStaffTeamController.h"
#import "ChoiceStaffTeamViewModel.h"
#import "ChoiceStaffTeamView.h"
#import "ChoiceStaffController.h"
#import "TeamModel.h"

@interface ChoiceStaffTeamController ()

@property(nonatomic,strong) ChoiceStaffTeamViewModel *choiceStaffTeamViewModel;

@property(nonatomic,strong) ChoiceStaffTeamView *choiceStaffTeamView;

@end

@implementation ChoiceStaffTeamController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.choiceStaffTeamView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"选择员工";
}


-(void)h_addSubviews{
    [self.view addSubview:self.choiceStaffTeamView];
}

-(void)h_bindViewModel{
    [[self.choiceStaffTeamViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        [self performSelectorOnMainThread:@selector(mainThread:) withObject:x waitUntilDone:YES];
    }];
}

-(void)mainThread:(NSNumber *)x{
    ChoiceStaffController *choiceStaff = [[ChoiceStaffController alloc] init];
    
    TeamModel *teamModel =self.choiceStaffTeamViewModel.arr[[x intValue]];
    choiceStaff.titleTeam = teamModel.deptNickName;
    choiceStaff.deptCode =  teamModel.deptCode;
    choiceStaff.companyCode = teamModel.companyCode;
    [self.navigationController pushViewController:choiceStaff animated:NO];

}

#pragma mark lazyload
-(ChoiceStaffTeamView *)choiceStaffTeamView{
    if (!_choiceStaffTeamView) {
        _choiceStaffTeamView = [[ChoiceStaffTeamView alloc] initWithViewModel:self.choiceStaffTeamViewModel];
    }
    return _choiceStaffTeamView;
    
}

-(ChoiceStaffTeamViewModel *)choiceStaffTeamViewModel{
    if (!_choiceStaffTeamViewModel) {
        _choiceStaffTeamViewModel = [[ChoiceStaffTeamViewModel alloc] init];
    }
    return _choiceStaffTeamViewModel;
}


@end
