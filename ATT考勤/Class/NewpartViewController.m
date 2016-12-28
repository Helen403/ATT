//
//  NewpartViewController.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "NewpartViewController.h"
#import "NewpartViewModel.h"
#import "NewpartView.h"
#import "CreateController.h"


@interface NewpartViewController ()

@property(nonatomic,strong) NewpartView *newpartView;

@property(nonatomic,strong) NewpartViewModel *newpartViewModel;


@end

@implementation NewpartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark system
-(void)updateViewConstraints{
    
    WS(weakSelf);
    [self.newpartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];

    [super updateViewConstraints];
}


#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"创建账户";
}

-(void)h_addSubviews{

    [self.view addSubview:self.newpartView];
}

-(void)h_bindViewModel{
    [[self.newpartViewModel.createclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        CreateController *create = [[CreateController alloc] init];
        
        [self.navigationController pushViewController:create animated:YES];
    }];
}


#pragma mark lazyload
-(NewpartView *)newpartView{
    if (!_newpartView) {
        _newpartView = [[NewpartView alloc] initWithViewModel:self.newpartViewModel];
    }
    return _newpartView;
}

-(NewpartViewModel *)newpartViewModel{
    if (!_newpartViewModel) {
        _newpartViewModel = [[NewpartViewModel alloc] init];
    }
    return _newpartViewModel;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}






@end
