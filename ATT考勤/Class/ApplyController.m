//
//  ResignationController.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ApplyController.h"
#import "ResignationViewModel.h"
#import "ApplyView.h"


@interface ApplyController ()

@property(nonatomic,strong) ResignationViewModel *resignalViewModel;

@property(nonatomic,strong) ApplyView *resignationView;

@end

@implementation ApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{

    WS(weakSelf);
    [self.resignationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_addSubviews{
    [self.view addSubview:self.resignationView];
}

-(void)h_bindViewModel{


}


#pragma mark lazyload
-(ApplyView *)resignationView{
    if (!_resignationView) {
        _resignationView = [[ApplyView alloc] initWithViewModel:self.resignalViewModel];
    }
    return _resignationView;
}

-(ResignationViewModel *)resignalViewModel{
    if (!_resignalViewModel) {
        _resignalViewModel = [[ResignationViewModel alloc] init];
    }
    return _resignalViewModel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
