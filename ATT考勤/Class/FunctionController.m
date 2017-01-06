//
//  FunctionController.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "FunctionController.h"
#import "FunctionView.h"
#import "FunctionViewModel.h"

@interface FunctionController ()

@property(nonatomic,strong) FunctionView *functionView;

@property(nonatomic,strong) FunctionViewModel *functionViewModel;


@end

@implementation FunctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];

    [super updateViewConstraints];
}


#pragma mark private

-(void)h_layoutNavigation{
    self.title = @"功能介绍";
}

-(void)h_addSubviews{

    [self.view addSubview:self.functionView];

}

-(void)h_bindViewModel{


}

#pragma mark lazyload
-(FunctionView *)functionView{
    if (!_functionView) {
        _functionView = [[FunctionView alloc] initWithViewModel:self.functionViewModel];
    }
    return _functionView;
}

-(FunctionViewModel *)functionViewModel{
    if (!_functionViewModel) {
        _functionViewModel = [[FunctionViewModel alloc] init];
    }
    return _functionViewModel;
}

@end
