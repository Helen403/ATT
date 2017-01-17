//
//  ShiftController.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ShiftController.h"
#import "ShiftViewModel.h"
#import "ShiftView.h"


@interface ShiftController ()

@property(nonatomic,strong) ShiftView *shiftView;

@property(nonatomic,strong) ShiftViewModel *shiftViewModel;

@end

@implementation ShiftController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.shiftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"换班申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.shiftView];
}

-(void)h_bindViewModel{
    
    [[self.shiftViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        //        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [self.navigationController popViewControllerAnimated:NO];
    }];
    
}


#pragma mark lazyload
-(ShiftView *)shiftView{
    if (!_shiftView) {
        _shiftView = [[ShiftView alloc] initWithViewModel:self.shiftViewModel];
    }
    return _shiftView;
}

-(ShiftViewModel *)shiftViewModel{
    if (!_shiftViewModel) {
        _shiftViewModel = [[ShiftViewModel alloc] init];
    }
    return _shiftViewModel;
    
}



@end
