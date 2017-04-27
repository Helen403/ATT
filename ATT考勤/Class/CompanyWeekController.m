//
//  CompanyWeekController.m
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CompanyWeekController.h"
#import "CompanyWeekViewModel.h"
#import "CompanyWeekView.h"


@interface CompanyWeekController ()


@property(nonatomic,strong) CompanyWeekViewModel *companyWeekViewModel;

@property(nonatomic,strong) CompanyWeekView *companyWeekView;

@end

@implementation CompanyWeekController


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
    self.title = @"公司考勤周报";
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
