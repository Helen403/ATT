//
//  MySchedulieController.m
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MySchedulieController.h"
#import "MySchedulieView.h"
#import "MySchedulieViewModel.h"

@interface MySchedulieController ()

@property(nonatomic,strong) MySchedulieView *mySchedulieView;

@property(nonatomic,strong) MySchedulieViewModel *mySchedulieViewModel;

@end

@implementation MySchedulieController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.mySchedulieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"我的排班";
}


-(void)h_addSubviews{
    [self.view addSubview:self.mySchedulieView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(MySchedulieView *)mySchedulieView{
    if (!_mySchedulieView) {
        _mySchedulieView = [[MySchedulieView alloc] initWithViewModel:self.mySchedulieViewModel];
    }
    return _mySchedulieView;
}

-(MySchedulieViewModel *)mySchedulieViewModel{
    if (!_mySchedulieViewModel) {
        _mySchedulieViewModel = [[MySchedulieViewModel alloc] init];
    }
    return _mySchedulieViewModel;
}





@end
