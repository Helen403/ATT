//
//  TeamOutWorkDetailsController.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamOutWorkDetailsController.h"
#import "TeamOutWorkDetailsView.h"
#import "TeamOutWorkDetailsViewModel.h"

@interface TeamOutWorkDetailsController ()

@property(nonatomic,strong) TeamOutWorkDetailsView *teamOutWorkDetailsView;

@property(nonatomic,strong) TeamOutWorkDetailsViewModel *teamOutWorkDetailsViewModel;

@end

@implementation TeamOutWorkDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.teamOutWorkDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
  
}


-(void)setEndDate:(NSString *)endDate{
    if (!endDate) {
        return;
    }
    _endDate = endDate;
    self.teamOutWorkDetailsView.deptCode = self.deptCode;
    self.teamOutWorkDetailsView.startDate = self.startDate;
    self.teamOutWorkDetailsView.endDate = endDate;
}

-(void)h_addSubviews{
    [self.view addSubview:self.teamOutWorkDetailsView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(TeamOutWorkDetailsView *)teamOutWorkDetailsView{
    if (!_teamOutWorkDetailsView) {
        _teamOutWorkDetailsView = [[TeamOutWorkDetailsView alloc] initWithViewModel:self.teamOutWorkDetailsViewModel];
    }
    return _teamOutWorkDetailsView;
}

-(TeamOutWorkDetailsViewModel *)teamOutWorkDetailsViewModel{
    if (!_teamOutWorkDetailsViewModel) {
        _teamOutWorkDetailsViewModel = [[TeamOutWorkDetailsViewModel alloc] init];
    }
    return _teamOutWorkDetailsViewModel;
}



@end
