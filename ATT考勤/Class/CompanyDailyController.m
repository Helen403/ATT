//
//  CompanyDailyController.m
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CompanyDailyController.h"
#import "CompanyDailyView.h"
#import "CompanyDailyViewModel.h"
#import "CompanyDailyDetailsController.h"
#import "CompanyDailyModel.h"

@interface CompanyDailyController ()

@property(nonatomic,strong) CompanyDailyView *companyDailyView;

@property(nonatomic,strong) CompanyDailyViewModel *companyDailyViewModel;

@end

@implementation CompanyDailyController


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.companyDailyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"公司考勤日报";
}


-(void)h_addSubviews{
    [self.view addSubview:self.companyDailyView];
}

-(void)h_bindViewModel{
    [[self.companyDailyViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        
        CompanyDailyModel *companyDailyModel = self.companyDailyViewModel.arr[x.intValue];
        
        CompanyDailyDetailsController *companyDailyDetails = [[CompanyDailyDetailsController alloc] init];
      
        companyDailyDetails.cardDate =  companyDailyModel.busDate;
        [self.navigationController pushViewController:companyDailyDetails animated:NO];
        
        
    }];
}

#pragma mark lazyload
-(CompanyDailyView *)companyDailyView{
    if (!_companyDailyView) {
        _companyDailyView = [[CompanyDailyView alloc] initWithViewModel:self.companyDailyViewModel];
    }
    return _companyDailyView;
}

-(CompanyDailyViewModel *)companyDailyViewModel{
    if (!_companyDailyViewModel) {
        _companyDailyViewModel = [[CompanyDailyViewModel alloc] init];
    }
    return _companyDailyViewModel;
}

@end
