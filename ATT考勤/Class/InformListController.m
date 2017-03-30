//
//  InformListController.m
//  ATT考勤
//
//  Created by Helen on 17/3/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "InformListController.h"
#import "InformListView.h"
#import "InformListViewModel.h"
#import "InformController.h"

@interface InformListController ()

@property(nonatomic,strong) InformListView *informListView;

@property(nonatomic,strong) InformListViewModel *informListViewModel;

@end

@implementation InformListController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.informListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"公司通知";
}

-(void)h_addSubviews{
    [self.view addSubview:self.informListView];
}

-(void)h_viewWillAppear{
    [self.informListView h_loadData];
}

-(void)h_bindViewModel{
    [[self.informListViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        InformController *Inform = [[InformController alloc] init];
        Inform.index = x.intValue;
        Inform.arr = self.informListViewModel.arr;
        
        [self.navigationController pushViewController:Inform animated:NO];
        
    }];
}

#pragma mark lazyload
-(InformListView *)informListView{
    if (!_informListView) {
        _informListView = [[InformListView alloc] initWithViewModel:self.informListViewModel];
    }
    return _informListView;
}

-(InformListViewModel *)informListViewModel{
    if (!_informListViewModel) {
        _informListViewModel = [[InformListViewModel alloc] init];
    }
    return _informListViewModel;
}


@end
