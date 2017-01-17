//
//  MyApplyController.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "MyApplyController.h"
#import "MyApplyView.h"
#import "MyApplyViewModel.h"

#import "LateController.h"
#import "LeaveController.h"
#import "OvertimeController.h"
#import "BusinessTravelController.h"
#import "GoOutController.h"
#import "ShiftController.h"
#import "MoveController.h"
#import "ResignationController.h"
#import "OffController.h"
#import "DrainPunchController.h"
#import "LeaveEarlyController.h"
#import "CostController.h"


@interface MyApplyController ()

@property(nonatomic,strong) MyApplyView *myapplyView;

@property(nonatomic,strong) MyApplyViewModel *myApplyViewModel;

@end

@implementation MyApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    
    [self.myapplyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
    }];
    
    
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_addSubviews{
    
    [self.view addSubview:self.myapplyView];
}

-(void)h_bindViewModel{
    
    [[self.myApplyViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        switch ([x intValue]) {
                //请假申请
            case 0:{
                
                LeaveController *leave = [[LeaveController alloc] init];
                
                [self.navigationController pushViewController:leave animated:NO];
                break;
            }
                //加班申请
            case 1:{
                
                OvertimeController *overtime = [[OvertimeController alloc] init];
                
                [self.navigationController pushViewController:overtime animated:NO];
                break;
            }
                //出差申请
            case 2:{
            
                BusinessTravelController *business = [[BusinessTravelController alloc] init];
                
                [self.navigationController pushViewController:business animated:NO];
                break;
            }
                
            case 3:{
             
                GoOutController *goOut = [[GoOutController alloc] init];
                
                [self.navigationController pushViewController:goOut animated:NO];
                break;
            }
                
               //换班申请
            case 4:{
                
                ShiftController *shift = [[ShiftController alloc] init];
                
                [self.navigationController pushViewController:shift animated:NO];
                break;
            }
                //换班申请
            case 5:{
                
                MoveController *move = [[MoveController alloc] init];
                
                [self.navigationController pushViewController:move animated:NO];
                break;
            }
                //辞职申请
            case 6:{
                
                ResignationController *resignation = [[ResignationController alloc] init];
                
                [self.navigationController pushViewController:resignation animated:NO];
                break;
            }
                
                //调休申请
            case 7:{
                
                OffController *off = [[OffController alloc] init];
                
                [self.navigationController pushViewController:off animated:NO];
                break;
            }
                
                //漏打卡申请
            case 8:{
                
                DrainPunchController *drainPunch = [[DrainPunchController alloc] init];
                
                [self.navigationController pushViewController:drainPunch animated:NO];
                break;
            }
                
                //消迟到申请
            case 9:{
                
                LateController *late = [[LateController alloc] init];
                
                [self.navigationController pushViewController:late animated:NO];
                break;
            }
                //消早退申请
            case 10:{
                
                LeaveEarlyController *leaveEarly = [[LeaveEarlyController alloc] init];
                
                [self.navigationController pushViewController:leaveEarly animated:NO];
                break;
            }
                //费用申请
            case 11:{
                
                CostController *cost = [[CostController alloc] init];
                
                [self.navigationController pushViewController:cost animated:NO];
                break;
            }
     
        }
       
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark lazyload
-(MyApplyView *)myapplyView{
    
    if (!_myapplyView) {
        _myapplyView = [[MyApplyView alloc] initWithViewModel:self.myApplyViewModel];
    }
    return _myapplyView;
}


-(MyApplyViewModel *)myApplyViewModel{
    if (!_myApplyViewModel) {
        _myApplyViewModel = [[MyApplyViewModel alloc] init];
    }
    return _myApplyViewModel;
}


@end
