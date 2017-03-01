//
//  ChangeNameController.m
//  ATT考勤
//
//  Created by Helen on 17/2/28.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChangeNameController.h"
#import "ChangeNameViewModel.h"
#import "ChangeNameView.h"

@interface ChangeNameController ()

@property(nonatomic,strong) ChangeNameViewModel *changeNameViewModel;

@property(nonatomic,strong) ChangeNameView *changeNameView;

@end

@implementation ChangeNameController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.changeNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"修改昵称";
}


-(void)h_addSubviews{
    [self.view addSubview:self.changeNameView];
}

-(void)h_bindViewModel{
    //修改昵称成功
    [[self.changeNameViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:NO];
            
        });
    }];
}

#pragma mark lazyload
-(ChangeNameView *)changeNameView{
    if (!_changeNameView) {
        _changeNameView = [[ChangeNameView alloc] initWithViewModel:self.changeNameViewModel];
    }
    return _changeNameView;
}

-(ChangeNameViewModel *)changeNameViewModel{
    if (!_changeNameViewModel) {
        _changeNameViewModel = [[ChangeNameViewModel alloc] init];
    }
    return _changeNameViewModel;
}



@end
