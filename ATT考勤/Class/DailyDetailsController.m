//
//  DailyDetailsController.m
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DailyDetailsController.h"
#import "DailyDetailsView.h"
#import "DailyDetailsViewModel.h"

@interface DailyDetailsController ()

@property(nonatomic,strong) DailyDetailsView *dailyDetailsView;

@property(nonatomic,strong) DailyDetailsViewModel *dailyDetailsViewModel;

@end

@implementation DailyDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.dailyDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"考勤日报详情";
}


-(void)h_addSubviews{
    [self.view addSubview:self.dailyDetailsView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(DailyDetailsView *)dailyDetailsView{
    if (!_dailyDetailsView) {
        _dailyDetailsView = [[DailyDetailsView alloc] initWithViewModel:self.dailyDetailsViewModel];
    }
    return _dailyDetailsView;
}

-(DailyDetailsViewModel *)dailyDetailsViewModel{
    if (!_dailyDetailsViewModel) {
        _dailyDetailsViewModel = [[DailyDetailsViewModel alloc] init];
    }
    return _dailyDetailsViewModel;
}



@end
