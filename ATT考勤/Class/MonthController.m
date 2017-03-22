//
//  MonthController.m
//  ATT考勤
//
//  Created by Helen on 17/3/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MonthController.h"
#import "MonthViewModel.h"
#import "MonthView.h"

@interface MonthController ()

@property(nonatomic,strong) MonthView *monthView;

@property(nonatomic,strong) MonthViewModel *monthViewModel;

@end

@implementation MonthController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.monthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"考勤月报";
}


-(void)h_addSubviews{
    [self.view addSubview:self.monthView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(MonthView *)monthView{
    if (!_monthView) {
        _monthView = [[MonthView alloc] initWithViewModel:self.monthViewModel];
    }
    return _monthView;
}

-(MonthViewModel *)monthViewModel{
    if (!_monthViewModel) {
        _monthViewModel = [[MonthViewModel alloc] init];
    }
    return _monthViewModel;
}



@end
