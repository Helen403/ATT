//
//  CompanyDailyDetailsController.m
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CompanyDailyDetailsController.h"
#import "CompanyDailyDetailsViewModel.h"
#import "CompanyDailyDetailsView.h"

@interface CompanyDailyDetailsController ()

@property(nonatomic,strong) CompanyDailyDetailsView *companyDailyDetailsView;

@property(nonatomic,strong) CompanyDailyDetailsViewModel *companyDailyDetailsViewModel;

@end

@implementation CompanyDailyDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.companyDailyDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    
}

-(void)h_addSubviews{
    [self.view addSubview:self.companyDailyDetailsView];
}


#pragma mark dataload
-(void)setCardDate:(NSString *)cardDate{
    
    if (!cardDate) {
        return;
    }
    _cardDate = cardDate;
   
    self.companyDailyDetailsView.cardDate = cardDate;
    
    self.title = [LSCoreToolCenter getFormatterYMD:cardDate];
}



-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(CompanyDailyDetailsView *)companyDailyDetailsView{
    if (!_companyDailyDetailsView) {
        _companyDailyDetailsView = [[CompanyDailyDetailsView alloc] initWithViewModel:self.companyDailyDetailsViewModel];
    }
    return _companyDailyDetailsView;
}


-(CompanyDailyDetailsViewModel *)companyDailyDetailsViewModel{
    if (!_companyDailyDetailsViewModel) {
        _companyDailyDetailsViewModel = [[CompanyDailyDetailsViewModel alloc] init];
    }
    return _companyDailyDetailsViewModel;
}


@end
