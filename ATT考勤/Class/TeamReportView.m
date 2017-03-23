//
//  TeamReportView.m
//  ATT考勤
//
//  Created by Helen on 17/3/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamReportView.h"
#import "TeamReportViewModel.h"
#import "UserModel.h"
#import "TeamReportCellView.h"


@interface TeamReportView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) TeamReportViewModel *teamReportViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end


@implementation TeamReportView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.teamReportViewModel = (TeamReportViewModel *)viewModel;
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
    [[self.teamReportViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.teamReportViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.teamReportViewModel.userCode = user.userCode;
    
    [self.teamReportViewModel.refreshDataCommand execute:nil];
}


#pragma mark lazyload
-(TeamReportViewModel *)teamReportViewModel{
    if (!_teamReportViewModel) {
        _teamReportViewModel = [[TeamReportViewModel alloc] init];
    }
    return _teamReportViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TeamReportCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamReportCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.teamReportViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeamReportCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamReportCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.teamReportModel = self.teamReportViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamReportCellView class])] cacheByIndexPath:indexPath configuration:^(TeamReportCellView *cell) {
        cell.teamReportModel = self.teamReportViewModel.arr[indexPath.row];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.teamReportViewModel.cellclickSubject sendNext:row];
}

@end
