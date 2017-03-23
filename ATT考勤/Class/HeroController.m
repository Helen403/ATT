//
//  HeroController.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HeroController.h"
#import "HeroViewModel.h"
#import "HeroView.h"

@interface HeroController ()

@property(nonatomic,strong) HeroViewModel *heroViewModel;

@property(nonatomic,strong) HeroView *heroView;

@end

@implementation HeroController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.heroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"工时英雄榜";
}


-(void)h_addSubviews{
    [self.view addSubview:self.heroView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(HeroView *)heroView{
    if (!_heroView) {
        _heroView = [[HeroView alloc] initWithViewModel:self.heroViewModel];
    }
    return _heroView;
}

-(HeroViewModel *)heroViewModel{
    if (!_heroViewModel) {
        _heroViewModel = [[HeroViewModel alloc] init];
    }
    return _heroViewModel;
}


@end
