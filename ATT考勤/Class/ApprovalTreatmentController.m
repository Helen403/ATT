//
//  ApprovalTreatmentController.m
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ApprovalTreatmentController.h"
#import "ApprovalTreatmentViewModel.h"
#import "ApprovalTreatmentView.h"

@interface ApprovalTreatmentController ()

@property(nonatomic,strong) ApprovalTreatmentViewModel *approvalTreatmentViewModel;

@property(nonatomic,strong) ApprovalTreatmentView *approvalTreatmentView;

@end

@implementation ApprovalTreatmentController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}
#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    
    [self.approvalTreatmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"我审批的";
}


-(void)h_addSubviews{
    [self.view addSubview:self.approvalTreatmentView];
}

-(void)h_bindViewModel{
    
}

-(void)setArr:(NSMutableArray *)arr{
    if (!arr) {
        return;
    }
    _arr = arr;
    
    self.approvalTreatmentViewModel.lateArr = arr;
   
    self.approvalTreatmentView.indexTmp = self.indexTmp;
   
    [self.approvalTreatmentView refreash:self.indexTmp];
 
}

#pragma mark lazyload
-(ApprovalTreatmentView *)approvalTreatmentView{
    if (!_approvalTreatmentView) {
        _approvalTreatmentView = [[ApprovalTreatmentView alloc] initWithViewModel:self.approvalTreatmentViewModel];
    }
    return _approvalTreatmentView;
}


-(ApprovalTreatmentViewModel *)approvalTreatmentViewModel{
    if (!_approvalTreatmentViewModel) {
        _approvalTreatmentViewModel = [[ApprovalTreatmentViewModel alloc] init];
    }
    return _approvalTreatmentViewModel;
}

@end
