//
//  AuditingController.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AuditingController.h"
#import "AuditingView.h"
#import "AuditingViewModel.h"


@interface AuditingController ()

@property(nonatomic,strong) AuditingView *auditingView;

@property(nonatomic,strong) AuditingViewModel *auditingViewModel;

@end

@implementation AuditingController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.auditingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private

-(void)h_addSubviews{
    [self.view addSubview:self.auditingView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(AuditingView *)auditingView{
    if (!_auditingView) {
        _auditingView = [[AuditingView alloc] initWithViewModel:self.auditingViewModel];
    }
    return _auditingView;
}

-(AuditingViewModel *)auditingViewModel{
    if (!_auditingViewModel) {
        _auditingViewModel = [[AuditingViewModel alloc] init];
    }
    return _auditingViewModel;
}



@end
