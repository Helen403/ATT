//
//  PersonalController.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "PersonalController.h"
#import "PersonalViewModel.h"
#import "PersonalView.h"

@interface PersonalController ()

@property(nonatomic,strong) PersonalViewModel *personalViewModel;

@property(nonatomic,strong) PersonalView *personalView;

@end

@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.personalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"个人考勤";
}


-(void)h_addSubviews{
    [self.view addSubview:self.personalView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(PersonalView *)personalView{
    if (!_personalView) {
        _personalView = [[PersonalView alloc] initWithViewModel:self.personalViewModel];
    }
    return _personalView;
}

-(PersonalViewModel *)personalViewModel{
    if (!_personalViewModel) {
        _personalViewModel = [[PersonalViewModel alloc] init];
    }
    return _personalViewModel;
}


@end
