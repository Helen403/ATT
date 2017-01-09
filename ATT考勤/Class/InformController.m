//
//  InformController.m
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "InformController.h"
#import "InformView.h"
#import "InformViewModel.h"

@interface InformController ()

@property(nonatomic,strong) InformView *informView;

@property(nonatomic,strong) InformViewModel *informViewModel;

@end

@implementation InformController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{

    WS(weakSelf);
    [self.informView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{

    self.title = @"公司通知";
}

-(void)h_addSubviews{
    [self.view addSubview:self.informView];
}

-(void)h_bindViewModel{


}


-(InformView *)informView{
    if (!_informView) {
        _informView = [[InformView alloc] initWithViewModel:self.informViewModel];
    }
    return _informView;
}

-(InformViewModel *)informViewModel{
    if (!_informViewModel) {
        _informViewModel = [[InformViewModel alloc] init];
    }
    return _informViewModel;

}

@end
