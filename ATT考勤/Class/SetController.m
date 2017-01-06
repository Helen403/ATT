//
//  SetController.m
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "SetController.h"
#import "SetView.h"
#import "SetViewModel.h"

#import "VersionController.h"
#import "TimeController.h"
#import "FunctionController.h"

#import "AboutController.h"
#import "CustomController.h"


@interface SetController ()

@property(nonatomic,strong) SetView *setView;

@property(nonatomic,strong) SetViewModel *setViewModel;

@end

@implementation SetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    
    WS(weakSelf);
    [self.setView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title  = @"设置";
    
}

-(void)h_addSubviews{
    [self.view addSubview:self.setView];
    
}

-(void)h_bindViewModel{
    
    [[self.setViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        
        NSInteger str = [x intValue];
        switch (str) {
                //版本号
            case 5:{
                VersionController *version = [[VersionController alloc] init];
                
                [self.navigationController pushViewController:version animated:NO];
                break;
            }
                //定时提醒
            case 2:{
                
                TimeController *time = [[TimeController alloc] init];
                
                [self.navigationController pushViewController:time animated:NO];
                break;
            }
               //功能介绍
            case 3:{
                FunctionController *function = [[FunctionController alloc] init];
                
                [self.navigationController pushViewController:function animated:NO];
                break;
            
            }
               //关于我们
            case 7:{
                AboutController *about = [[AboutController alloc] init];
                
                [self.navigationController pushViewController:about animated:NO];
                break;
            }
                
            case 6:{
                CustomController *custom = [[CustomController alloc] init];
                
                [self.navigationController pushViewController:custom animated:NO];
                
                break;
            }
                
        }
        
        NSLog(@"%@",x);
    }];
    
    [[self.setViewModel.exitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        
    }];
    
}

#pragma mark lazyload
-(SetView *)setView{
    if (!_setView) {
        _setView = [[SetView alloc] initWithViewModel:self.setViewModel];
    }
    return _setView;
}

-(SetViewModel *)setViewModel{
    if (!_setViewModel) {
        _setViewModel = [[SetViewModel alloc] init];
    }
    return _setViewModel;
    
}

@end
