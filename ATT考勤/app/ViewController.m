//
//  ViewController.m
//  ATT考勤
//
//  Created by Helen on 17/3/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ViewController.h"
#import "MyCalendarView.h"

@interface ViewController ()

@property(nonatomic,strong) MyCalendarView *myCalendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.automaticallyAdjustsScrollViewInsets = NO;//关闭自动适应

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.myCalendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"部门考勤";
}

-(void)h_addSubviews{
    [self.view addSubview:self.myCalendarView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload

-(MyCalendarView *)myCalendarView{
    if (!_myCalendarView) {
        _myCalendarView = [[MyCalendarView alloc] init];
    }
    return _myCalendarView;
}

@end
