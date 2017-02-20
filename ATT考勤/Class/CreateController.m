//
//  CreateController.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "CreateController.h"
#import "CreateView.h"
#import "CreateViewModel.h"


#import "BuildRoleController.h"

@interface CreateController ()

@property(nonatomic,strong) CreateView *createView;

@property(nonatomic,strong) CreateViewModel *createViewModel;

@end

@implementation CreateController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf)
    [self.createView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"创建账户";
}

-(void)h_addSubviews{

    [self.view addSubview:self.createView];
}

-(void)h_bindViewModel{

    [[self.createViewModel.buildRoleclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *x) {
  
        
        [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
    }];
}

-(void)mainThread{
    
    BuildRoleController *buildRole = [[BuildRoleController alloc] init];
    buildRole.index = 0;
    [self.navigationController pushViewController:buildRole animated:YES];

}

#pragma mark lazyload
-(CreateView *)createView{
    if (!_createView) {
        _createView = [[CreateView alloc] initWithViewModel:self.createViewModel];
    }
    return _createView;
}
-(CreateViewModel *)createViewModel{
    if (!_createViewModel) {
        _createViewModel = [[CreateViewModel alloc] init];
        _createViewModel.telphone = self.telphone;
    }
    return _createViewModel;
}


@end
