//
//  TimeControllerViewController.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TimeController.h"
#import "TimeView.h"
#import "TimeViewModel.h"


@interface TimeController ()

@property(nonatomic,strong) TimeView *timeView;

@property(nonatomic,strong) TimeViewModel *timeViewModel;

@end

@implementation TimeController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
#pragma mark system
-(void)updateViewConstraints{

    WS(weakSelf);
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma private
-(void)h_layoutNavigation{
    self.title = @"打卡声音";
}

-(void)h_addSubviews{
    [self.view addSubview:self.timeView];
}

-(void)h_bindViewModel{

}

-(void)h_viewWillAppear{
    [self.timeView h_viewWillAppear];
}

-(void)h_viewWillDisappear{
    [self.timeView h_viewWillDisappear];
}

#pragma mark lazyload
-(TimeView *)timeView{
    if (!_timeView) {
        _timeView = [[TimeView alloc] initWithViewModel:self.timeViewModel];
    }
    return _timeView;
}

-(TimeViewModel *)timeViewModel{
    if (!_timeViewModel) {
        _timeViewModel = [[TimeViewModel alloc] init];
    }
    return _timeViewModel;
}




@end
