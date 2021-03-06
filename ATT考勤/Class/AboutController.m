//
//  AboutController.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AboutController.h"
#import "AboutView.h"
#import "AboutViewModel.h"
#import "AgreementController.h"
#import "NetController.h"


@interface AboutController()

@property(nonatomic,strong) AboutView *aboutView;

@property(nonatomic,strong) AboutViewModel *aboutViewModel;

@end

@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    
    WS(weakSelf);
    [self.aboutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}


#pragma mark private
-(void)h_layoutNavigation{
    
    self.title = @"关于我们";
}


-(void)h_addSubviews{
    [self.view addSubview:self.aboutView];
}

-(void)h_bindViewModel{
    
    [[self.aboutViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        switch (x.intValue) {
                //公司官网
            case 2:{
               
                NetController *application = [[NetController alloc] init];
                
                [self.navigationController pushViewController:application animated:NO];
                break;
            }
                //协议
            case 3:{
                AgreementController *application = [[AgreementController alloc] init];
                
                [self.navigationController pushViewController:application animated:NO];
                break;
                
            }
        }
    }];
}


#pragma mark lazyload
-(AboutView *)aboutView{
    if (!_aboutView) {
        _aboutView = [[AboutView alloc] initWithViewModel:self.aboutViewModel];
    }
    return _aboutView;
}

-(AboutViewModel *)aboutViewModel{
    if (!_aboutViewModel) {
        _aboutViewModel = [[AboutViewModel alloc] init];
    }
    return _aboutViewModel;
}


@end
