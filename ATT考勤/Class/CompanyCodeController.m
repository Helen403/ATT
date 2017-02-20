//
//  CompanyCodeController.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "CompanyCodeController.h"
#import "CompanyCodeView.h"
#import "CompanyCodeViewModel.h"


@interface CompanyCodeController ()

@property(nonatomic,strong) CompanyCodeView *companyCodeView;

@property(nonatomic,strong) CompanyCodeViewModel *companyCodeViewModel;

@end

@implementation CompanyCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark system
-(void)updateViewConstraints{
    WS(weakSelf);
    [self.companyCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"加入公司";
}



-(void)h_addSubviews{
    [self.view addSubview:self.companyCodeView];
}



-(void)h_bindViewModel{
    
    [[self.companyCodeViewModel.addclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
    }];
}


-(void)mainThread{
    
    if (self.index == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}

#pragma lazyload
-(CompanyCodeView *)companyCodeView{
    if (!_companyCodeView) {
        _companyCodeView = [[CompanyCodeView alloc] initWithViewModel:self.companyCodeViewModel];
    }
    return _companyCodeView;
}

-(CompanyCodeViewModel *)companyCodeViewModel{
    if (!_companyCodeViewModel) {
        _companyCodeViewModel = [[CompanyCodeViewModel alloc] init];
    }
    return _companyCodeViewModel;
}


@end
