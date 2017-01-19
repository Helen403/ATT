//
//  MyExamineController.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "MyExamineController.h"
#import "MyExamineViewModel.h"
#import "MyExamineView.h"
#import "TreatController.h"
#import "ProcessedController.h"
#import "RefuseController.h"
#import "CopyController.h"

@interface MyExamineController ()

@property(nonatomic,strong) MyExamineView *myExamineView;

@property(nonatomic,strong) MyExamineViewModel *myExamineViewModel;

@end

@implementation MyExamineController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark system
-(void)updateViewConstraints{
    
    [self.myExamineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
    }];
    
    
    [super updateViewConstraints];
}


-(void)h_addSubviews{
    
    [self.view addSubview:self.myExamineView];
}

-(void)h_bindViewModel{
    
    
    [[self.myExamineViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        switch ([x integerValue]) {
                //待处理
            case 0:{
                TreatController *treat = [[TreatController alloc] init];
                
                [self.navigationController pushViewController:treat animated:NO];
                break;
            }
                //已处理
            case 1:{
                
                ProcessedController *processed = [[ProcessedController alloc] init];
                
                [self.navigationController pushViewController:processed animated:NO];
                break;
            }
                //已拒绝
            case 2:{
                RefuseController *refuse = [[RefuseController alloc] init];
                
                [self.navigationController pushViewController:refuse animated:NO];
          
                break;
            }
                //抄送我的
            case 3:{
                CopyController *to = [[CopyController alloc] init];
                
                [self.navigationController pushViewController:to animated:NO];

                break;
            }
             
        }
        
    }];
    
}

#pragma mark lazyload
-(MyExamineView *)myExamineView{
    if (!_myExamineView) {
        _myExamineView = [[MyExamineView alloc] initWithViewModel:self.myExamineViewModel];
    }
    return _myExamineView;
    
}

-(MyExamineViewModel *)myExamineViewModel{
    if (!_myExamineViewModel) {
        _myExamineViewModel = [[MyExamineViewModel alloc] init];
    }
    return _myExamineViewModel;
}

@end
