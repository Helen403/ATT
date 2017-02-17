//
//  EmployeeController.m
//  ATT考勤
//
//  Created by Helen on 17/1/10.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "EmployeeController.h"
#import "EmployeeView.h"
#import "EmployeeViewModel.h"

@interface EmployeeController ()

@property(nonatomic,strong) EmployeeViewModel *employeeViewModel;

@property(nonatomic,strong) EmployeeView *employeeView;

@end

@implementation EmployeeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{

    WS(weakSelf);
    [self.employeeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"员工信息";
}

-(void)h_addSubviews{
    [self.view addSubview:self.employeeView];
}

-(void)h_bindViewModel{

}

#pragma mark lazyload
-(EmployeeView *)employeeView{
    if (!_employeeView) {
        _employeeView = [[EmployeeView alloc] initWithViewModel:self.employeeViewModel];
    }
    return _employeeView;
}

-(EmployeeViewModel *)employeeViewModel{
    if (!_employeeViewModel) {
        _employeeViewModel = [[EmployeeViewModel alloc] init];
        _employeeViewModel.empCode = self.addressListModel.empCode;
    }
    return _employeeViewModel;
}

@end
