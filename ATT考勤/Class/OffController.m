//
//  OffController.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "OffController.h"
#import "OffView.h"
#import "OffViewModel.h"

@interface OffController ()

@property(nonatomic,strong) OffView *offView;

@property(nonatomic,strong) OffViewModel *offViewModel;

@end

@implementation OffController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.offView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"调休申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.offView];
}

-(void)h_bindViewModel{
    
    [[self.offViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:NO];
          
          
        });
    }];
}



#pragma mark lazyload
-(OffView *)offView{
    if (!_offView) {
        _offView = [[OffView alloc] initWithViewModel:self.offViewModel];
    }
    return _offView;
}

-(OffViewModel *)offViewModel{
    if (!_offViewModel) {
        _offViewModel = [[OffViewModel alloc] init];
    }
    return _offViewModel;
    
}



@end
