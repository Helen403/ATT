//
//  TeamAttendanceController.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamAttendanceController.h"
#import "TeamAttendanceView.h"
#import "TeamAttendanceViewModel.h"

@interface TeamAttendanceController ()

@property(nonatomic,strong) TeamAttendanceView *teamAttendanceView;

@property(nonatomic,strong) TeamAttendanceViewModel *teamAttendanceViewModel;

@end

@implementation TeamAttendanceController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.teamAttendanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"部门考勤";
}


-(void)h_addSubviews{
    [self.view addSubview:self.teamAttendanceView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(TeamAttendanceView *)teamAttendanceView{
    if (!_teamAttendanceView) {
        _teamAttendanceView = [[TeamAttendanceView alloc] initWithViewModel:self.teamAttendanceViewModel];
    }
    return _teamAttendanceView;
}

-(TeamAttendanceViewModel *)teamAttendanceViewModel{
    if (!_teamAttendanceViewModel) {
        _teamAttendanceViewModel = [[TeamAttendanceViewModel alloc] init];
    }
    return _teamAttendanceViewModel;
}




@end
