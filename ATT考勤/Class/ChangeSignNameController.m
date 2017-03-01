//
//  ChangeSignNameController.m
//  ATT考勤
//
//  Created by Helen on 17/3/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChangeSignNameController.h"
#import "ChangeSignNameViewModel.h"
#import "ChangeSignNameView.h"

@interface ChangeSignNameController ()

@property(nonatomic,strong) ChangeSignNameViewModel *changeSignNameViewModel;

@property(nonatomic,strong) ChangeSignNameView *changeSignNameView;

@end

@implementation ChangeSignNameController

- (void)viewDidLoad {
    [super viewDidLoad];

}
#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.changeSignNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"修改签名";
}


-(void)h_addSubviews{
    [self.view addSubview:self.changeSignNameView];
}

-(void)h_bindViewModel{
    //修改昵称成功
    [[self.changeSignNameViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:NO];
            
        });
    }];
}

#pragma mark lazyload
-(ChangeSignNameView *)changeSignNameView{
    if (!_changeSignNameView) {
        _changeSignNameView = [[ChangeSignNameView alloc] initWithViewModel:self.changeSignNameViewModel];
    }
    return _changeSignNameView;
}

-(ChangeSignNameViewModel *)changeSignNameViewModel{
    if (!_changeSignNameViewModel) {
        _changeSignNameViewModel = [[ChangeSignNameViewModel alloc] init];
    }
    return _changeSignNameViewModel;
}



@end
