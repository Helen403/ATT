//
//  BuildRoleView.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "BuildRoleView.h"
#import "BuildRoleViewModel.h"
#import "BuildRoleCellView.h"

@interface BuildRoleView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) BuildRoleViewModel *buildRoleViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end
@implementation BuildRoleView

-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.buildRoleViewModel = (BuildRoleViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}


#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [super updateConstraints];
}

#pragma mark private;
-(void)h_setupViews{
    
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

-(void)h_bindViewModel{
//    [self addDynamic:self];
}

#pragma mark lazyload
-(BuildRoleViewModel *)buildRoleViewModel{
    if (!_buildRoleViewModel) {
        _buildRoleViewModel = [[BuildRoleViewModel alloc] init];
    }
    return _buildRoleViewModel;
    
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BuildRoleCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([BuildRoleCellView class])]];
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.buildRoleViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BuildRoleCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([BuildRoleCellView class])] forIndexPath:indexPath];
    
    cell.buildRoleModel = self.buildRoleViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.buildRoleViewModel.companyCodeclickSubject sendNext:row];
}


@end
