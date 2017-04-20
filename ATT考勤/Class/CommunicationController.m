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
#import "AddressListController.h"
#import "EmployeeController.h"
#import "CommunicationModel.h"

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
    [[self.communicationViewModel.myCompanySubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
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
    
    [[self.communicationViewModel.searchSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        AddressListController *application = [[AddressListController alloc] init];
        
        [self.navigationController pushViewController:application animated:NO];
    }];
    
    [[self.communicationViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        EmployeeController *employee = [[EmployeeController alloc] init];
        AddressListModel *addressListModel = [[AddressListModel alloc] init];
        
        CommunicationModel *communicationModel =  self.communicationViewModel.arr[[x intValue]];
        addressListModel.position = communicationModel.position;
        addressListModel.fullTimeCultural= communicationModel.fullTimeCultural;
        addressListModel.empNation = communicationModel.empNation;
        addressListModel.empProvice = communicationModel.empProvice;
        addressListModel.empBirthDate = communicationModel.empBirthDate;
        addressListModel.empPhotos = communicationModel.empPhotos;
        addressListModel.empQQ = communicationModel.empQQ;
        addressListModel.empEmail = communicationModel.empEmail; addressListModel.isMarriage = communicationModel.isMarriage;  addressListModel.enterDate = communicationModel.enterDate;  addressListModel.empCode = communicationModel.empCode;  addressListModel.empSex = communicationModel.empSex;  addressListModel.empWebChatId = communicationModel.empWebChatId;
        addressListModel.leaveDate = communicationModel.leaveDate;
        addressListModel.empNation = communicationModel.empNation;  addressListModel.deptCode = communicationModel.deptCode;
        addressListModel.phoneDeviceName = communicationModel.phoneDeviceName;
        addressListModel.empName = communicationModel.empName;
        addressListModel.positionlevel = communicationModel.positionlevel;
        addressListModel.idNumber = communicationModel.idNumber;
        addressListModel.empStatus = communicationModel.empStatus;
        addressListModel.userCode = communicationModel.userCode;
        addressListModel.empId = communicationModel.empId;
        addressListModel.empColor = communicationModel.empColor;
        addressListModel.empStreet = communicationModel.empStreet;
        addressListModel.empCity = communicationModel.empCity;
        addressListModel.empTelphone = communicationModel.empTelphone;
        addressListModel.companyCode = communicationModel.companyCode;
        addressListModel.fullTimeProfession = communicationModel.fullTimeProfession;
        employee.addressListModel = addressListModel;
        
        [self.navigationController pushViewController:employee animated:NO];
        
    }];
    
}

-(void)h_viewWillAppear{
    [self.communicationView h_refreash];
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
