//
//  WeekController.m
//  ATT考勤
//
//  Created by Helen on 17/3/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "WeekController.h"
#import "WeekView.h"
#import "WeekViewModel.h"
#import "WeekModel.h"
#import "WeekDetailsController.h"

@interface WeekController ()

@property(nonatomic,strong) WeekView *weekView;

@property(nonatomic,strong) WeekViewModel *weekViewModel;

@end

@implementation WeekController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"考勤周报";
}


-(void)h_addSubviews{
    [self.view addSubview:self.weekView];
}

-(void)h_bindViewModel{
    [[self.weekViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        WeekDetailsController *weekDetails = [[WeekDetailsController alloc] init];
        WeekModel *weekModel = self.weekViewModel.arr[x.intValue];
        weekDetails.week = weekModel.week;
        weekDetails.weekHours = weekModel.weekHours;
        weekDetails.startDate = weekModel.startDate;
        weekDetails.endDate = weekModel.endDate;
        
        [self.navigationController pushViewController:weekDetails animated:NO];

    }];
}

#pragma mark lazyload
-(WeekView *)weekView{
    if (!_weekView) {
        _weekView = [[WeekView alloc] initWithViewModel:self.weekViewModel];
    }
    return _weekView;
}

-(WeekViewModel *)weekViewModel{
    if (!_weekViewModel) {
        _weekViewModel = [[WeekViewModel alloc] init];
    }
    return _weekViewModel;
}


@end
