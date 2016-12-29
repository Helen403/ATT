//
//  ResignationController.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ApplyController.h"



#import "MyApplyController.h"
#import "MyExamineController.h"

#import "ZJScrollPageView.h"


@interface ApplyController ()<ZJScrollPageViewDelegate>

@property(strong, nonatomic)NSArray<NSString *> *titles;

@property(strong, nonatomic)NSMutableArray<UIViewController *> *childVcs;

@end

@implementation ApplyController

-(void)viewWillAppear:(BOOL)animated{
    [self hideNavigationBar:YES animated:NO];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self hideNavigationBar:NO animated:NO];
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)h_addSubviews{

    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    style.autoAdjustTitlesWidth = YES;
    style.adjustCoverOrLineWidth = YES;
    style.selectedTitleColor = MAIN_ORANGER;
    self.titles = @[@"我申请的",
                    @"我审批的",
                    ];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    [self.view addSubview:scrollPageView];
    
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}


- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = [self.childVcs objectAtIndex:index];
    }

    return childVc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

-(NSMutableArray<UIViewController *> *)childVcs{
    if (!_childVcs) {
        _childVcs = [NSMutableArray array];
        [_childVcs addObject:[[MyApplyController alloc] init]];
        [_childVcs addObject:[[MyExamineController alloc] init]];
    }
    return _childVcs;
}


@end
