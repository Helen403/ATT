//
//  CopyDetailsController.m
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CopyDetailsController.h"
#import "CopyDetailsView.h"
#import "CopyDetailsViewModel.h"
@interface CopyDetailsController ()

@property(nonatomic,strong) CopyDetailsView *toDetailsView;

@property(nonatomic,strong) CopyDetailsViewModel *toDetailsViewModel;

@end

@implementation CopyDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.toDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"抄送我的";
}


-(void)h_addSubviews{
    [self.view addSubview:self.toDetailsView];
}

-(void)h_bindViewModel{
    
}


-(void)setArr:(NSMutableArray *)arr{
    if (!arr) {
        return;
    }
    _arr = arr;
    
    self.toDetailsViewModel.lateArr = arr;
    
    self.toDetailsViewModel.indexTmp = self.indexTmp;
    
    [self.toDetailsView refreash:self.indexTmp];
    
}


#pragma mark lazyload
-(CopyDetailsView *)toDetailsView{
    if (!_toDetailsView) {
        _toDetailsView = [[CopyDetailsView alloc] initWithViewModel:self.toDetailsViewModel];
    }
    return _toDetailsView;
}

-(CopyDetailsViewModel *)toDetailsViewModel{
    if (!_toDetailsViewModel) {
        _toDetailsViewModel = [[CopyDetailsViewModel alloc] init];
    }
    return _toDetailsViewModel;
}


@end
