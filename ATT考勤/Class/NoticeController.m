//
//  NoticeController.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "NoticeController.h"
#import "NoticeViewModel.h"
#import "NoticeView.h"

@interface NoticeController()

@property(nonatomic,strong) NoticeView *noticeView;

@property(nonatomic,strong) NoticeViewModel *noticeViewModel;

@end

@interface NoticeController ()

@end

@implementation NoticeController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark system
-(void)updateViewConstraints{

    WS(weakSelf);
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"公司公告";
}

-(void)h_addSubviews{
    [self.view addSubview:self.noticeView];
}

-(void)h_bindViewModel{

}


-(void)setArr:(NSMutableArray *)arr{
    if (!arr) {
        return;
    }
    _arr = arr;

    self.noticeViewModel.preArr = arr;
    self.noticeView.index = self.index;
}


#pragma mark lazyload
-(NoticeView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[NoticeView alloc] initWithViewModel:self.noticeViewModel];
    }
    return _noticeView;
}

-(NoticeViewModel *)noticeViewModel{
    if (!_noticeViewModel) {
        _noticeViewModel = [[NoticeViewModel alloc] init];
    }
    return _noticeViewModel;
}





@end
