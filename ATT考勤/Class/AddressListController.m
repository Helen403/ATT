//
//  AddressListController.m
//  ATT考勤
//
//  Created by Helen on 17/1/10.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AddressListController.h"
#import "AddressListView.h"
#import "AddressListViewModel.h"

#import "TeamController.h"
#import "EmployeeController.h"


@interface AddressListController ()

@property(nonatomic,strong) AddressListView *addressListView;

@property(nonatomic,strong) AddressListViewModel *addressListViewModel;

@end

@implementation AddressListController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark system
-(void)updateViewConstraints{
    
    WS(weakSelf);
    [self.addressListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"通讯录";
}

-(void)h_addSubviews{
    [self.view addSubview:self.addressListView];
}

-(void)h_bindViewModel{
    
    //跳转到部门通讯
    [[self.addressListViewModel.teamclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        TeamController *team = [[TeamController alloc] init];
        
        [self.navigationController pushViewController:team animated:NO];
        
    }];
    
    
    //点击每个人
    [[self.addressListViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        EmployeeController *employee = [[EmployeeController alloc] init];
        
        [self.navigationController pushViewController:employee animated:NO];
        
        
        NSLog(@"%@",x);
    }];
    
}

#pragma mark lazyload
-(AddressListView *)addressListView{
    if (!_addressListView) {
        _addressListView = [[AddressListView alloc] initWithViewModel:self.addressListViewModel];
    }
    return _addressListView;
}

-(AddressListViewModel *)addressListViewModel{
    if (!_addressListViewModel) {
        _addressListViewModel = [[AddressListViewModel alloc] init];
    }
    return _addressListViewModel;
}

@end
