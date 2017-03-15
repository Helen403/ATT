//
//  ChoiceStaffController.m
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChoiceStaffController.h"
#import "ChoiceStaffView.h"
#import "ChoiceStaffViewModel.h"

#import "LateController.h"


@interface ChoiceStaffController ()

@property(nonatomic,strong) ChoiceStaffView *choiceStaffView;

@property(nonatomic,strong) ChoiceStaffViewModel *choiceStaffViewModel;

@end

@implementation ChoiceStaffController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.choiceStaffView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"选择员工";
}

-(void)h_addSubviews{
    [self.view addSubview:self.choiceStaffView];
}

-(void)h_loadData{
    
    self.choiceStaffViewModel.companyCode = self.companyCode;
    self.choiceStaffViewModel.deptCode = self.deptCode;
    [self.choiceStaffViewModel.refreshDataCommand execute:nil];
}

-(void)h_bindViewModel{
    [[self.choiceStaffViewModel.sendSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplyManView" object:self.choiceStaffViewModel.selectorPatnArray];
        NSArray *temArray = self.navigationController.viewControllers;
        [self.navigationController popToViewController:temArray[1] animated:NO];
    }];
}

-(void)h_viewWillDisappear{
    self.choiceStaffViewModel.selectorPatnArray = nil;
}

-(void)setTitleTeam:(NSString *)titleTeam{
    if (!titleTeam) {
        return;
    }
    _titleTeam = titleTeam;
    self.choiceStaffView.teamTitle = self.titleTeam;
}

#pragma mark lazyload
-(ChoiceStaffView *)choiceStaffView{
    if (!_choiceStaffView) {
        _choiceStaffView = [[ChoiceStaffView alloc] initWithViewModel:self.choiceStaffViewModel];
        
    }
    return _choiceStaffView;
}


-(ChoiceStaffViewModel *)choiceStaffViewModel{
    if (!_choiceStaffViewModel) {
        _choiceStaffViewModel = [[ChoiceStaffViewModel alloc] init];
      
    }
    return _choiceStaffViewModel;
}


@end
