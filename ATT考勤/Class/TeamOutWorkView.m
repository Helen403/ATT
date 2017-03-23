
//
//  TeamOutWorkView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamOutWorkView.h"
#import "TeamOutWorkViewModel.h"
#import "TeamOutWorkCellView.h"

@interface TeamOutWorkView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) TeamOutWorkViewModel *teamOutWorkViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end


@implementation TeamOutWorkView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.teamOutWorkViewModel = (TeamOutWorkViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [[self.teamOutWorkViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.teamOutWorkViewModel.companyCode = companyCode;
    [self.teamOutWorkViewModel.refreshDataCommand execute:nil];
}


#pragma mark lazyload
-(TeamOutWorkViewModel *)teamOutWorkViewModel{
    if (!_teamOutWorkViewModel) {
        _teamOutWorkViewModel = [[TeamOutWorkViewModel alloc] init];
    }
    return _teamOutWorkViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TeamOutWorkCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamOutWorkCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.teamOutWorkViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeamOutWorkCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamOutWorkCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.teamOutWorkModel = self.teamOutWorkViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamOutWorkCellView class])] cacheByIndexPath:indexPath configuration:^(TeamOutWorkCellView *cell) {
        cell.teamOutWorkModel = self.teamOutWorkViewModel.arr[indexPath.row];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.teamOutWorkViewModel.cellclickSubject sendNext:row];
}


@end
