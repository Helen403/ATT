//
//  CustomController.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CustomController.h"
#import "CustomViewModel.h"
#import "CustomView.h"


@interface CustomController ()

@property(nonatomic,strong) CustomView *customView;

@property(nonatomic,strong) CustomViewModel *customViewModel;

@end

@implementation CustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{

    WS(weakSelf);
    [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"客服中心";
}

-(void)h_addSubviews{
    [self.view addSubview:self.customView];
}

-(void)h_bindViewModel{


}


#pragma mark lazyload
-(CustomView *)customView{
    if (!_customView) {
        _customView = [[CustomView alloc] initWithViewModel:self.customViewModel];
    }
    return _customView;
}

-(CustomViewModel *)customViewModel{
    if (!_customViewModel) {
        _customViewModel = [[CustomViewModel alloc] init];
    }
    return _customViewModel;
}



@end
