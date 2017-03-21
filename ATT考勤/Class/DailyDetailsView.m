//
//  DailyDetailsView.m
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DailyDetailsView.h"
#import "DailyDetailsViewModel.h"

@interface DailyDetailsView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) DailyDetailsViewModel *dailyDetailsViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation DailyDetailsView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.dailyDetailsViewModel = (DailyDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
 
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(DailyDetailsViewModel *)dailyDetailsViewModel{
    if (!_dailyDetailsViewModel) {
        _dailyDetailsViewModel = [[DailyDetailsViewModel alloc] init];
    }
    return _dailyDetailsViewModel;
}


@end
