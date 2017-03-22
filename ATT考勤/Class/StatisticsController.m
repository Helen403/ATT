//
//  StatisticsController.m
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "StatisticsController.h"
#import "StatisticsView.h"
#import "StatisticsViewModel.h"

#import "TeamAttendanceController.h"
#import "PersonalController.h"
#import "DailyController.h"
#import "WeekController.h"
#import "MonthController.h"

@interface StatisticsController ()

@property(nonatomic,strong) StatisticsView *statisticsView;

@property(nonatomic,strong) StatisticsViewModel *statisticsViewModel;

@end

@implementation StatisticsController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark system
-(void)updateViewConstraints{
    
    WS(weakSelf);
    [self.statisticsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"统计";
}

-(void)h_addSubviews{
    [self.view addSubview:self.statisticsView];
}

-(void)h_bindViewModel{
    
    [[self.statisticsViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        switch ([x intValue]) {
                //考勤日报
            case 0:{
                DailyController *daily = [[DailyController alloc] init];
                
                [self.navigationController pushViewController:daily animated:NO];
                break;
            }
                //考勤周报
            case 1:{
                WeekController *week = [[WeekController alloc] init];
                
                [self.navigationController pushViewController:week animated:NO];
                 break;
            }
                //考勤月报
            case 2:{
                MonthController *month = [[MonthController alloc] init];
                
                [self.navigationController pushViewController:month animated:NO];
                break;
            }
                
        }
        
//        if ( == 0) {
//
//          
//        }else{
//            
//            TeamAttendanceController *team = [[TeamAttendanceController alloc] init];
//            
//            [self.navigationController pushViewController:team animated:NO];
//        }
        
        
    }];
}

#pragma mark lazyload
-(StatisticsView *)statisticsView{
    if (!_statisticsView) {
        _statisticsView = [[StatisticsView alloc] initWithViewModel:self.statisticsViewModel];
    }
    return _statisticsView;
}

-(StatisticsViewModel *)statisticsViewModel{
    if (!_statisticsViewModel) {
        _statisticsViewModel = [[StatisticsViewModel alloc] init];
    }
    return _statisticsViewModel;
}






@end
