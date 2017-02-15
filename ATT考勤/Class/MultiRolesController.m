//
//  MultiRolesController.m
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MultiRolesController.h"
#import "MultiRolesView.h"
#import "MultiRolesViewModel.h"

#import "XCFTabBarController.h"

@interface MultiRolesController ()

@property(nonatomic,strong) MultiRolesView *multiRolesView;

@property(nonatomic,strong) MultiRolesViewModel *multiRolesViewModel;

@end

@implementation MultiRolesController

-(void)viewWillAppear:(BOOL)animated{
    
    [self hideNavigationBar:YES animated:NO];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self hideNavigationBar:NO animated:NO];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.multiRolesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"切换角色";
   
}

-(void)h_addSubviews{
    [self.view addSubview:self.multiRolesView];
}

-(void)h_bindViewModel{
    [[self.multiRolesViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {

        [self performSelectorOnMainThread:@selector(mainClick) withObject:nil waitUntilDone:YES];
    }];
}

-(void)mainClick{
   [UIApplication sharedApplication].keyWindow.rootViewController =[[XCFTabBarController alloc] init];
}

#pragma mark lazyload
-(MultiRolesView *)multiRolesView{
    if (!_multiRolesView) {
        _multiRolesView = [[MultiRolesView alloc] initWithViewModel:self.multiRolesViewModel];
    }
    return _multiRolesView;
}

-(MultiRolesViewModel *)multiRolesViewModel{
    if (!_multiRolesViewModel) {
        _multiRolesViewModel = [[MultiRolesViewModel alloc] init];
    }
    return _multiRolesViewModel;
}



@end
