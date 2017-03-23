//
//  TeamReportController.m
//  ATT考勤
//
//  Created by Helen on 17/3/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamReportController.h"
#import "TeamReportViewModel.h"
#import "TeamReportView.h"

@interface TeamReportController ()

@property(nonatomic,strong) TeamReportViewModel *teamReportViewModel;

@property(nonatomic,strong) TeamReportView *teamReportView;

@end

@implementation TeamReportController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.teamReportView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"部门周报";
}


-(void)h_addSubviews{
    [self.view addSubview:self.teamReportView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(TeamReportView *)teamReportView{
    if (!_teamReportView) {
        _teamReportView = [[TeamReportView alloc] initWithViewModel:self.teamReportViewModel];
    }
    return _teamReportView;
}

-(TeamReportViewModel *)teamReportViewModel{
    if (!_teamReportViewModel) {
        _teamReportViewModel = [[TeamReportViewModel alloc] init];
    }
    return _teamReportViewModel;
}


@end
