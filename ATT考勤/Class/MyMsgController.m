//
//  MyMsgController.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyMsgController.h"
#import "MyMsgViewModel.h"
#import "MyMsgView.h"


#import "ChatController.h"

@interface MyMsgController ()

@property(nonatomic,strong) MyMsgView *myMsgView;

@property(nonatomic,strong) MyMsgViewModel *myMsgViewModel;

@end

@implementation MyMsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"我的消息";
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.myMsgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

-(void)h_addSubviews{
    [self.view addSubview:self.myMsgView];
}

-(void)h_bindViewModel{
    [[self.myMsgViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        ChatController *chat = [[ChatController alloc] init];
        
        [self.navigationController pushViewController:chat animated:NO];
        
    }];
}

#pragma mark lazyload
-(MyMsgView *)myMsgView{
    if (!_myMsgView) {
        _myMsgView = [[MyMsgView alloc] initWithViewModel:self.myMsgViewModel];
    }
    return _myMsgView;
}

-(MyMsgViewModel *)myMsgViewModel{
    if (!_myMsgViewModel) {
        _myMsgViewModel = [[MyMsgViewModel alloc] init];
    }
    return _myMsgViewModel;
}

@end
