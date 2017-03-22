//
//  DailyController.m
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DailyController.h"
#import "DailyView.h"
#import "DailyViewModel.h"
#import "DailyDetailsController.h"
#import "DailyModel.h"

@interface DailyController ()

@property(nonatomic,strong) DailyView *dailyView;

@property(nonatomic,strong) DailyViewModel *dailyViewModel;

@end

@implementation DailyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.dailyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"考勤日报";
}


-(void)h_addSubviews{
    [self.view addSubview:self.dailyView];
}

-(void)h_bindViewModel{
    [[self.dailyViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        DailyDetailsController *dailyDetails = [[DailyDetailsController alloc] init];
        DailyModel *dailyModel = self.dailyViewModel.arr[x.intValue];
        dailyDetails.busDate = dailyModel.cardDate;
        [self.navigationController pushViewController:dailyDetails animated:NO];
        
        
        
    }];
}

#pragma mark lazyload
-(DailyView *)dailyView{
    if (!_dailyView) {
        _dailyView = [[DailyView alloc] initWithViewModel:self.dailyViewModel];
    }
    return _dailyView;
}

-(DailyViewModel *)dailyViewModel{
    if (!_dailyViewModel) {
        _dailyViewModel = [[DailyViewModel alloc] init];
    }
    return _dailyViewModel;
}



@end
