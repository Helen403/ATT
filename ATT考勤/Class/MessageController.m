//
//  MessageController.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MessageController.h"
#import "MessageView.h"
#import "MessageViewModel.h"

@interface MessageController ()

@property(nonatomic,strong) MessageView *messageView;

@property(nonatomic,strong) MessageViewModel *messageViewModel;

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"消息通知";
}

-(void)h_addSubviews{
    [self.view addSubview:self.messageView];
}

-(void)h_bindViewModel{

}

-(void)h_viewWillAppear{
    [self.messageView h_viewWillAppear];
}

-(void)h_viewWillDisappear{
    [self.messageView h_viewWillDisappear];
}

#pragma mark lazyload
-(MessageView *)messageView{
    if (!_messageView) {
        _messageView = [[MessageView alloc] initWithViewModel:self.messageViewModel];
    }
    return _messageView;
}

-(MessageViewModel *)messageViewModel{
    if (!_messageViewModel) {
        _messageViewModel = [[MessageViewModel alloc] init];
    }
    return _messageViewModel;
}



@end
