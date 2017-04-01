//
//  DealWithController.m
//  ATT考勤
//
//  Created by Helen on 16/12/29.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "DealWithController.h"
#import "DealWithView.h"
#import "DealWithViewModel.h"

@interface DealWithController ()

@property(nonatomic,strong) DealWithView *dealWithView;

@property(nonatomic,strong) DealWithViewModel *dealWithViewModel;

@end

@implementation DealWithController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.dealWithView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}



-(void)h_addSubviews{
    [self.view addSubview:self.dealWithView];
}

-(void)h_bindViewModel{

}

-(void)h_viewWillAppear{
    //[self.dealWithView h_loadData];
}

#pragma mark lazyload
-(DealWithView *)dealWithView{
    if (!_dealWithView) {
        _dealWithView =  [[DealWithView alloc]initWithViewModel:self.dealWithViewModel ];
    }
    return _dealWithView;
}

-(DealWithViewModel *)dealWithViewModel{
    if (!_dealWithViewModel) {
        _dealWithViewModel = [[DealWithViewModel alloc] init];
    }
    return _dealWithViewModel;
}

@end
