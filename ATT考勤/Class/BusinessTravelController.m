//
//  BusinessTravelController.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "BusinessTravelController.h"
#import "BusinessTravelView.h"
#import "BusinessTravelViewModel.h"


@interface BusinessTravelController ()

@property(nonatomic,strong) BusinessTravelView *businessTraveView;

@property(nonatomic,strong) BusinessTravelViewModel *businessTravelViewModel;

@end

@implementation BusinessTravelController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.businessTraveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
    
}

#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"出差申请";
}

-(void)h_addSubviews{
    [self.view addSubview:self.businessTraveView];
}

-(void)h_bindViewModel{
    
    [[self.businessTravelViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        //        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [self.navigationController popViewControllerAnimated:NO];
    }];
    
}


#pragma mark lazyload
-(BusinessTravelView *)businessTraveView{
    if (!_businessTraveView) {
        _businessTraveView = [[BusinessTravelView alloc] initWithViewModel:self.businessTravelViewModel];
    }
    return _businessTraveView;
}

-(BusinessTravelViewModel *)businessTravelViewModel{
    if (!_businessTravelViewModel) {
        _businessTravelViewModel = [[BusinessTravelViewModel alloc] init];
    }
    return _businessTravelViewModel;
    
}





@end
