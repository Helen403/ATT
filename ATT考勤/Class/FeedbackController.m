//
//  FeedbackController.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "FeedbackController.h"
#import "FeedbackView.h"
#import "FeedbackViewModel.h"

@interface FeedbackController ()

@property(nonatomic,strong) FeedbackView *feedbackView;

@property(nonatomic,strong) FeedbackViewModel *feedbackViewModel;

@end

@implementation FeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{

    WS(weakSelf);
    [self.feedbackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_addSubviews{
    [self.view addSubview:self.feedbackView];
}

-(void)h_bindViewModel{

}

-(void)h_viewWillAppear{
    [self.feedbackView h_viewWillAppear];
}



#pragma mark lazyload
-(FeedbackView *)feedbackView{
    if (!_feedbackView) {
        _feedbackView = [[FeedbackView alloc] initWithViewModel:self.feedbackViewModel];
    }
    return _feedbackView;

}

-(FeedbackViewModel *)feedbackViewModel{
    if (!_feedbackViewModel) {
        _feedbackViewModel = [[FeedbackViewModel alloc] init];
    }
    return _feedbackViewModel;

}

    

@end
