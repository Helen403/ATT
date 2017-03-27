//
//  NoticeListController.m
//  ATT考勤
//
//  Created by Helen on 17/3/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "NoticeListController.h"
#import "NoticeListView.h"
#import "NoticeListViewModel.h"
#import "NoticeController.h"

@interface NoticeListController ()

@property(nonatomic,strong) NoticeListView *noticeListView;

@property(nonatomic,strong) NoticeListViewModel *noticeListViewModel;

@end

@implementation NoticeListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.noticeListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"公司公告";
}


-(void)h_addSubviews{
    [self.view addSubview:self.noticeListView];
}

-(void)h_viewWillAppear{
    [self.noticeListView h_loadData];
}

-(void)h_bindViewModel{
    [[self.noticeListViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        NoticeController *notice = [[NoticeController alloc] init];
        notice.index = x.intValue;
        notice.arr = self.noticeListViewModel.arr;

        [self.navigationController pushViewController:notice animated:NO];

    }];
}

#pragma mark lazyload
-(NoticeListView *)noticeListView{
    if (!_noticeListView) {
        _noticeListView = [[NoticeListView alloc] initWithViewModel:self.noticeListViewModel];
    }
    return _noticeListView;
}

-(NoticeListViewModel *)noticeListViewModel{
    if (!_noticeListViewModel) {
        _noticeListViewModel = [[NoticeListViewModel alloc] init];
    }
    return _noticeListViewModel;
}



@end
