//
//  CopyController.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CopyController.h"
#import "CopyView.h"
#import "CopyViewModel.h"

@interface CopyController ()

@property(nonatomic,strong) CopyViewModel *toViewModel;

@property(nonatomic,strong) CopyView *toView;

@end

@implementation CopyController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"抄送我的";
}

-(void)h_addSubviews{
    [self.view addSubview:self.toView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(CopyView *)toView{
    if (!_toView) {
        _toView = [[CopyView alloc] initWithViewModel:self.toViewModel];
    }
    return _toView;
}

-(CopyViewModel *)toViewModel{
    if (!_toViewModel) {
        _toViewModel = [[CopyViewModel alloc] init];
    }
    return _toViewModel;
}


@end
