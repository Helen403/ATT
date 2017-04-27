//
//  TeamMonthController.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamMonthController.h"
#import "TeamMonthView.h"
#import "TeamMonthViewModel.h"

@interface TeamMonthController ()

@property(nonatomic,strong) TeamMonthView *teamMonthView;

@property(nonatomic,strong) TeamMonthViewModel *teamMonthViewModel;

@end

@implementation TeamMonthController



#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.teamMonthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"部门考勤月报";
}


-(void)h_addSubviews{
    [self.view addSubview:self.teamMonthView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(TeamMonthView *)teamMonthView{
    if (!_teamMonthView) {
        _teamMonthView = [[TeamMonthView alloc] initWithViewModel:self.teamMonthViewModel];
    }
    return _teamMonthView;
}

-(TeamMonthViewModel *)teamMonthViewModel{
    if (!_teamMonthViewModel) {
        _teamMonthViewModel = [[TeamMonthViewModel alloc] init];
    }
    return _teamMonthViewModel;
}



@end
