//
//  AlreadyDetailsController.m
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AlreadyDetailsController.h"
#import "AlreadyDetailsView.h"
#import "AlreadyDetailsViewModel.h"

@interface AlreadyDetailsController ()

@property(nonatomic,strong) AlreadyDetailsView *alreadyDetailsView;

@property(nonatomic,strong) AlreadyDetailsViewModel *alreadyDetailsViewModel;

@end

@implementation AlreadyDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.alreadyDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"已处理";
}


-(void)h_addSubviews{
    [self.view addSubview:self.alreadyDetailsView];
}

-(void)h_bindViewModel{
    
}


-(void)setArr:(NSMutableArray *)arr{
    if (!arr) {
        return;
    }
    _arr = arr;
    
    self.alreadyDetailsViewModel.lateArr = arr;
    
    self.alreadyDetailsViewModel.indexTmp = self.indexTmp;
    
    [self.alreadyDetailsView refreash:self.indexTmp];
    
}

#pragma mark lazyload
-(AlreadyDetailsView *)alreadyDetailsView{
    if (!_alreadyDetailsView) {
        _alreadyDetailsView = [[AlreadyDetailsView alloc] initWithViewModel:self.alreadyDetailsViewModel];
    }
    return _alreadyDetailsView;
}


-(AlreadyDetailsViewModel *)alreadyDetailsViewModel{
    if (!_alreadyDetailsViewModel) {
        _alreadyDetailsViewModel = [[AlreadyDetailsViewModel alloc] init];
    }
    return _alreadyDetailsViewModel;
}


@end
