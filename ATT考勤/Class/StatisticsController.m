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


#import "DailyController.h"
#import "WeekController.h"
#import "MonthController.h"
#import "TeamDailyController.h"
#import "TeamReportController.h"
#import "TeamMonthController.h"
#import "TeamOutWorkController.h"
#import "HeroController.h"
#import "SignController.h"
#import "TeamRedBlackController.h"
#import "MyContrastController.h"
#import "MyTrajectoryController.h"


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
           
                //我的对比
            case 3:{
                MyContrastController *myContrast = [[MyContrastController alloc] init];
                
                [self.navigationController pushViewController:myContrast animated:NO];
                break;
            }
                //我的轨迹
            case 4:{
                MyTrajectoryController *myTrajectory = [[MyTrajectoryController alloc] init];
                
                [self.navigationController pushViewController:myTrajectory animated:NO];
                break;
            }
                //部门考勤日报
            case 5:{
                TeamDailyController *teamDaily = [[TeamDailyController alloc] init];
                
                [self.navigationController pushViewController:teamDaily animated:NO];
                break;
            }
                //部门考勤周报
            case 6:{
                TeamReportController *teamReport = [[TeamReportController alloc] init];
                
                [self.navigationController pushViewController:teamReport animated:NO];
                break;
            }
                //部门考勤月报
            case 7:{
                TeamMonthController *teamMonth = [[TeamMonthController alloc] init];
                
                [self.navigationController pushViewController:teamMonth animated:NO];
                break;
            }
                //部门考勤外勤
            case 8:{
                TeamOutWorkController *teamOutWork = [[TeamOutWorkController alloc] init];
                
                [self.navigationController pushViewController:teamOutWork animated:NO];
                break;
            }
                //工时英雄榜
            case 9:{
                HeroController *hero = [[HeroController alloc] init];
                
                [self.navigationController pushViewController:hero animated:NO];
                break;
            }
                //签到英雄榜
            case 10:{
                SignController *sign = [[SignController alloc] init];
                
                [self.navigationController pushViewController:sign animated:NO];
                break;
            }
                //部门红黑榜
            case 11:{
                TeamRedBlackController *teamRedBlack = [[TeamRedBlackController alloc] init];
                
                [self.navigationController pushViewController:teamRedBlack animated:NO];
                break;
            }
              
             
        }
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
