//
//  TreatController.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TreatController.h"
#import "ZJScrollPageView.h"
#import "PendingController.h"
#import "MeApplyController.h"

@interface TreatController ()<ZJScrollPageViewDelegate>

@property(strong, nonatomic)NSArray<NSString *> *titles;

@property(strong, nonatomic)NSMutableArray<HViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;

@end

@implementation TreatController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"待处理";
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
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
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

#pragma mark lazyload
-(NSMutableArray<HViewController<ZJScrollPageViewChildVcDelegate> *> *)childVcs{
    if (!_childVcs) {
        _childVcs = [NSMutableArray array];
        [_childVcs addObject:[[MeApplyController alloc] init]];
        [_childVcs addObject:[[PendingController alloc] init]];
    }
    return _childVcs;
}



@end
