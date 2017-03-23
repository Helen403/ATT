//
//  MonthDetailsController.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MonthDetailsController.h"
#import "MonthDetailsView.h"
#import "MonthDetailsViewModel.h"


@interface MonthDetailsController ()

@property(nonatomic,strong) MonthDetailsView *monthDetailsView;

@property(nonatomic,strong) MonthDetailsViewModel *monthDetailsViewModel;

@end

@implementation MonthDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.monthDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{

}


-(void)h_addSubviews{
    [self.view addSubview:self.monthDetailsView];
}

-(void)h_bindViewModel{
    
}

-(void)setEndDate:(NSString *)endDate{
    if (!endDate) {
        return;
    }
    _endDate = endDate;
    self.monthDetailsView.startDate = self.startDate;
    self.monthDetailsView.weekHours = self.weekHours;
    self.monthDetailsView.endDate = endDate;
    
    self.title = [LSCoreToolCenter getFormatterYM:self.month];
    
}

#pragma mark lazyload
-(MonthDetailsView *)monthDetailsView{
    if (!_monthDetailsView) {
        _monthDetailsView = [[MonthDetailsView alloc] initWithViewModel:self.monthDetailsViewModel];
    }
    return _monthDetailsView;
}

-(MonthDetailsViewModel *)monthDetailsViewModel{
    if (!_monthDetailsViewModel) {
        _monthDetailsViewModel = [[MonthDetailsViewModel alloc] init];
    }
    return _monthDetailsViewModel;
}


@end
