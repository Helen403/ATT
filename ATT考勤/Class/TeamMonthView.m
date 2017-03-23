//
//  TeamMonthView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamMonthView.h"
#import "TeamMonthViewModel.h"
#import "TeamMonthCellView.h"
#import "UserModel.h"


@interface TeamMonthView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) TeamMonthViewModel *teamMonthViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end


@implementation TeamMonthView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.teamMonthViewModel = (TeamMonthViewModel *)viewModel;
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
    [[self.teamMonthViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.teamMonthViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.teamMonthViewModel.userCode = user.userCode;
    
    [self.teamMonthViewModel.refreshDataCommand execute:nil];
}


#pragma mark lazyload
-(TeamMonthViewModel *)teamMonthViewModel{
    if (!_teamMonthViewModel) {
        _teamMonthViewModel = [[TeamMonthViewModel alloc] init];
    }
    return _teamMonthViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TeamMonthCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamMonthCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.teamMonthViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeamMonthCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamMonthCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.teamMonthModel = self.teamMonthViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamMonthCellView class])] cacheByIndexPath:indexPath configuration:^(TeamMonthCellView *cell) {
        cell.teamMonthModel = self.teamMonthViewModel.arr[indexPath.row];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.teamMonthViewModel.cellclickSubject sendNext:row];
}


@end
