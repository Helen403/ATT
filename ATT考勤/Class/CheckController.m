//
//  CheckController.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CheckController.h"
#import "HACursor.h"
#import "CalendarView.h"
#import "CheckViewModel.h"
#import "ListView.h"
#import "ContrastView.h"
#import "CountView.h"
#import "TrajectoryView.h"

@interface CheckController ()

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSMutableArray *pageViews;

@property(nonatomic,strong) CalendarView *calendarView;

@property(nonatomic,strong) ListView *listView;

@property(nonatomic,strong) CountView *countView;

@property(nonatomic,strong) ContrastView *contrastView;

@property(nonatomic,strong)  TrajectoryView *trajectoryView;

@property(nonatomic,strong) HACursor *cursor;

@property(nonatomic,strong) CheckViewModel *checkViewModel;

@end

@implementation CheckController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"考勤";
  
}

-(void)h_addSubviews{
    //不允许有重复的标题
    self.titles = @[@"日历",@"列表",@"统计",@"对比",@"轨迹"];
    [self.view addSubview:self.cursor];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
- (NSMutableArray *)createPageViews{
    NSMutableArray *pageViews = [NSMutableArray array];
    
    [pageViews addObject:self.calendarView];

    [pageViews addObject:self.listView];
    
    [pageViews addObject:self.countView];
    
    [pageViews addObject:self.contrastView];

    [pageViews addObject:self.trajectoryView];
    
    return pageViews;
}

-(CalendarView *)calendarView{
    if (!_calendarView) {
        _calendarView = [[CalendarView alloc] initWithViewModel:self.checkViewModel];
    }
    return _calendarView;
}

-(ListView *)listView{
    if (!_listView) {
        _listView = [[ListView alloc] initWithViewModel:self.checkViewModel];
    }
    return _listView;
}

-(CountView *)countView{
    if (!_countView) {
        _countView = [[CountView alloc] initWithViewModel:self.checkViewModel];
    }
    return _countView;
}

-(TrajectoryView *)trajectoryView{
    if (!_trajectoryView) {
        _trajectoryView = [[TrajectoryView alloc] initWithViewModel:self.checkViewModel];
    }
    return _trajectoryView;
}

-(ContrastView *)contrastView{
    if (!_contrastView) {
        _contrastView = [[ContrastView alloc] initWithViewModel:self.checkViewModel];
    }
    return _contrastView;
}


-(HACursor *)cursor{
    if (!_cursor) {
        _cursor = [[HACursor alloc] init];
        _cursor.frame = CGRectMake(0, 0, SCREEN_WIDTH , 45);
        _cursor.backgroundColor = white_color;
        _cursor.titles = self.titles;
        _cursor.pageViews = [self createPageViews];
        //设置根滚动视图的高度
        _cursor.rootScrollViewHeight = self.view.frame.size.height - 45;
        //默认值是白色
        _cursor.titleNormalColor = MAIN_PAN_2;
        //默认值是白色
        _cursor.titleSelectedColor = MAIN_ORANGER;
        //是否显示排序按钮
        //cursor.showSortbutton = YES;
        //默认的最小值是5，小于默认值的话按默认值设置
        _cursor.minFontSize = 16;
        //默认的最大值是25，小于默认值的话按默认值设置，大于默认值按设置的值处理
        _cursor.maxFontSize = 16;
        _cursor.defFontSize = 16;
//        _cursor.isGraduallyChangFont = NO;
        //在isGraduallyChangFont为NO的时候，isGraduallyChangColor不会有效果
        //    cursor.isGraduallyChangColor = NO;
    }
    return _cursor;
}


-(CheckViewModel *)checkViewModel{
    if (!_checkViewModel) {
        _checkViewModel = [[CheckViewModel alloc] init];
    }
    return _checkViewModel;
}

@end
