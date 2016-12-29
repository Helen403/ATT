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
#import "PendingController.h"
#import "DealWithController.h"


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
        
       
        
        
        if ([x isEqualToNumber:@(0)]) {
            PendingController *pending = [[PendingController alloc] init];
            
            [self.navigationController pushViewController:pending animated:NO];
//            ShowMaskStatus(@"正在加载");
        }else{
            DealWithController *dealWith = [[DealWithController alloc] init];
            
            [self.navigationController pushViewController:dealWith animated:NO];
        }
       
        

        NSLog(@"%@",x);
        
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark lazy
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
