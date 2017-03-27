//
//  WeekDetailsController.m
//  ATT考勤
//
//  Created by Helen on 17/3/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "WeekDetailsController.h"
#import "WeekDetailsViewModel.h"
#import "WeekDetailsView.h"

@interface WeekDetailsController ()

@property(nonatomic,strong) WeekDetailsViewModel *weekDetailsViewModel;

@property(nonatomic,strong) WeekDetailsView *weekDetailsView;

@end

@implementation WeekDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.weekDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    
}


-(void)h_addSubviews{
    [self.view addSubview:self.weekDetailsView];
}

-(void)h_bindViewModel{
    
}

-(void)setEndDate:(NSString *)endDate{
    if (!endDate) {
        return;
    }
    _endDate = endDate;
    self.weekDetailsView.startDate = self.startDate;
    self.weekDetailsView.weekHours = self.weekHours;
    self.weekDetailsView.endDate = endDate;
    
    self.title = self.week;
}

#pragma mark lazyload
-(WeekDetailsView *)weekDetailsView{
    if (!_weekDetailsView) {
        _weekDetailsView = [[WeekDetailsView alloc] initWithViewModel:self.weekDetailsViewModel];
    }
    return _weekDetailsView;
}

-(WeekDetailsViewModel *)weekDetailsViewModel{
    if (!_weekDetailsViewModel) {
        _weekDetailsViewModel = [[WeekDetailsViewModel alloc] init];
    }
    return _weekDetailsViewModel;
}


@end
