//
//  CompanyMonthController.m
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CompanyMonthController.h"
#import "companyWeekView.h"
#import "companyWeekViewModel.h"

@interface CompanyMonthController ()

@property(nonatomic,strong) CompanyWeekView *companyWeekView;

@property(nonatomic,strong) CompanyWeekViewModel *companyWeekViewModel;

@end

@implementation CompanyMonthController


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.companyWeekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"公司考勤月报";
}


-(void)h_addSubviews{
    [self.view addSubview:self.companyWeekView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(CompanyWeekView *)companyWeekView{
    if (!_companyWeekView) {
        _companyWeekView = [[CompanyWeekView alloc] initWithViewModel:self.companyWeekViewModel];
    }
    return _companyWeekView;
}

-(CompanyWeekViewModel *)companyWeekViewModel{
    if (!_companyWeekViewModel) {
        _companyWeekViewModel = [[CompanyWeekViewModel alloc] init];
    }
    return _companyWeekViewModel;
}


@end
