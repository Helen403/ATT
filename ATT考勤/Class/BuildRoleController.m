//
//  BuildRoleController.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "BuildRoleController.h"
#import "BuildRoleView.h"
#import "BuildRoleViewModel.h"

#import "CompanyCodeController.h"

#import "ScanCodeController.h"

@interface BuildRoleController ()

@property(nonatomic,strong) BuildRoleView *buildRoleView;

@property(nonatomic,strong) BuildRoleViewModel *buildRoleViewModel;

@end

@implementation BuildRoleController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark system
-(void)updateViewConstraints{
    
    WS(weakSelf);
    [self.buildRoleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"新建角色";
    
}

-(void)h_addSubviews{
    [self.view addSubview:self.buildRoleView];
    
}
-(void)h_bindViewModel{
    
    [[self.buildRoleViewModel.companyCodeclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        switch ([x intValue]) {
            case 0:{
                ScanCodeController *scanCode = [[ScanCodeController alloc] init];
                
                [self.navigationController pushViewController:scanCode animated:YES];
            }
                break;
                
            case 1:{
                CompanyCodeController *company = [[CompanyCodeController alloc] init];
                
                [self.navigationController pushViewController:company animated:YES];
            }
                break;
        }
        
        
    }];
}



#pragma mark lazyload
-(BuildRoleView *)buildRoleView{
    if (!_buildRoleView) {
        _buildRoleView = [[BuildRoleView alloc] initWithViewModel:self.buildRoleViewModel];
    }
    return _buildRoleView;
}
-(BuildRoleViewModel *)buildRoleViewModel{
    if (!_buildRoleViewModel) {
        _buildRoleViewModel = [[BuildRoleViewModel alloc] init];
    }
    return _buildRoleViewModel;
    
}

@end
