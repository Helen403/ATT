//
//  MeApplyController.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MeApplyController.h"
#import "MeApplyView.h"
#import "MeApplyViewModel.h"

@interface MeApplyController ()

@property(nonatomic,strong) MeApplyView *meView;

@property(nonatomic,strong) MeApplyViewModel *meViewModel;

@end

@implementation MeApplyController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{

    WS(weakSelf);
    [self.meView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_addSubviews{
    [self.view addSubview:self.meView];
}


-(void)h_bindViewModel{

}

#pragma mark lazyload
-(MeApplyView *)meView{
    if (!_meView) {
        _meView = [[MeApplyView alloc] initWithViewModel:self.meViewModel];
    }
    return _meView;
}

-(MeApplyViewModel *)meViewModel{
    if (!_meViewModel) {
        _meViewModel = [[MeApplyViewModel alloc] init];
    }
    return _meViewModel;
}


@end
