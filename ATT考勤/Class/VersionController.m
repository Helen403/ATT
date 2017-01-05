//
//  VersionController.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "VersionController.h"
#import "VersionView.h"
#import "VersionViewModel.h"

@interface VersionController ()

@property(nonatomic,strong) VersionView *versionView;

@property(nonatomic,strong) VersionViewModel *versionViewModel;

@end

@implementation VersionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.versionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"版本检测";
}


-(void)h_addSubviews{

    [self.view addSubview:self.versionView];
}

-(void)h_bindViewModel{


}


#pragma mark lazyload
-(VersionView *)versionView{
    if (!_versionView) {
        _versionView = [[VersionView alloc] initWithViewModel:self.versionViewModel];
    }
    return _versionView;
}

-(VersionViewModel *)versionViewModel{
    if (!_versionViewModel) {
        _versionViewModel = [[VersionViewModel alloc] init];
    }
    return _versionViewModel;
}




@end
