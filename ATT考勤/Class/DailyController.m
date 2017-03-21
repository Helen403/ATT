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
