//
//  TeamRedBlackController.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamRedBlackController.h"
#import "TeamRedBlackViewModel.h"
#import "TeamRedBlackView.h"

@interface TeamRedBlackController ()

@property(nonatomic,strong) TeamRedBlackViewModel *teamRedBlackViewModel;

@property(nonatomic,strong) TeamRedBlackView *teamRedBlackView;

@end

@implementation TeamRedBlackController

- (void)viewDidLoad {
    [super viewDidLoad];

}
#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.teamRedBlackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"部门红黑榜";
}


-(void)h_addSubviews{
    [self.view addSubview:self.teamRedBlackView];
}

-(void)h_bindViewModel{
    
}

#pragma mark lazyload
-(TeamRedBlackView *)teamRedBlackView{
    if (!_teamRedBlackView) {
        _teamRedBlackView = [[TeamRedBlackView alloc] initWithViewModel:self.teamRedBlackViewModel];
    }
    return _teamRedBlackView;
}

-(TeamRedBlackViewModel *)teamRedBlackViewModel{
    if (!_teamRedBlackViewModel) {
        _teamRedBlackViewModel = [[TeamRedBlackViewModel alloc] init];
    }
    return _teamRedBlackViewModel;
}


@end
