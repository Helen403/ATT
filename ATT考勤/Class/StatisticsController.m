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
