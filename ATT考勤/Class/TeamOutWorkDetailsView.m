//
//  TeamOutWorkDetailsView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamOutWorkDetailsView.h"
#import "TeamOutWorkDetailsCellView.h"
#import "TeamOutWorkDetailsViewModel.h"


@interface TeamOutWorkDetailsView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) TeamOutWorkDetailsViewModel *teamOutWorkDetailsViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end


@implementation TeamOutWorkDetailsView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.teamOutWorkDetailsViewModel = (TeamOutWorkDetailsViewModel *)viewModel;
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
    [[self.teamOutWorkDetailsViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)setEndDate:(NSString *)endDate{
    if (!endDate) {
        return;
    }
    _endDate = endDate;
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.teamOutWorkDetailsViewModel.companyCode = companyCode;
    
    self.teamOutWorkDetailsViewModel.deptCode = self.deptCode;
    self.teamOutWorkDetailsViewModel.startDate = self.startDate;
    self.teamOutWorkDetailsViewModel.endDate = endDate;
    [self.teamOutWorkDetailsViewModel.refreshDataCommand execute:nil];
}

-(void)h_loadData{
   
}


#pragma mark lazyload
-(TeamOutWorkDetailsViewModel *)teamOutWorkDetailsViewModel{
    if (!_teamOutWorkDetailsViewModel) {
        _teamOutWorkDetailsViewModel = [[TeamOutWorkDetailsViewModel alloc] init];
    }
    return _teamOutWorkDetailsViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TeamOutWorkDetailsCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamOutWorkDetailsCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.teamOutWorkDetailsViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeamOutWorkDetailsCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamOutWorkDetailsCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.teamOutWorkDetailsModel = self.teamOutWorkDetailsViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:150];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.teamOutWorkDetailsViewModel.cellclickSubject sendNext:row];
}
@end
