//
//  RefuseDetailsController.m
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "RefuseDetailsController.h"
#import "RefuseDetailsView.h"
#import "RefuseDetailsViewModel.h"

@interface RefuseDetailsController ()

@property(nonatomic,strong) RefuseDetailsView *refuseDetailsView;

@property(nonatomic,strong) RefuseDetailsViewModel *refuseDetailsViewModel;

@end

@implementation RefuseDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.refuseDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"已拒接";
}


-(void)h_addSubviews{
    [self.view addSubview:self.refuseDetailsView];
}

-(void)h_bindViewModel{
    
}

-(void)setArr:(NSMutableArray *)arr{
    if (!arr) {
        return;
    }
    _arr = arr;
    
    self.refuseDetailsViewModel.lateArr = arr;
    
    self.refuseDetailsViewModel.indexTmp = self.indexTmp;
    
    [self.refuseDetailsView refreash:self.indexTmp];
    
}

#pragma mark lazyload
-(RefuseDetailsView *)refuseDetailsView{
    if (!_refuseDetailsView) {
        _refuseDetailsView = [[RefuseDetailsView alloc] initWithViewModel:self.refuseDetailsViewModel];
    }
    return _refuseDetailsView;
}


-(RefuseDetailsViewModel *)refuseDetailsViewModel{
    if (!_refuseDetailsViewModel) {
        _refuseDetailsViewModel = [[RefuseDetailsViewModel alloc] init];
    }
    return _refuseDetailsViewModel;
}


@end
