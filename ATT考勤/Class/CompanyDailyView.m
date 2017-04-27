//
//  CompanyDailyView.m
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CompanyDailyView.h"
#import "CompanyDailyViewModel.h"
#import "CompanyDailyCellView.h"

@interface CompanyDailyView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) CompanyDailyViewModel *companyDailyViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end


@implementation CompanyDailyView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.companyDailyViewModel = (CompanyDailyViewModel *)viewModel;
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
    [[self.companyDailyViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.companyDailyViewModel.companyCode = companyCode;

    [self.companyDailyViewModel.refreshDataCommand execute:nil];
}


#pragma mark lazyload
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[CompanyDailyCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyDailyCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.companyDailyViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyDailyCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyDailyCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.companyDailyModel = self.companyDailyViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyDailyCellView class])] cacheByIndexPath:indexPath configuration:^(CompanyDailyCellView *cell) {
        cell.companyDailyModel = self.companyDailyViewModel.arr[indexPath.row];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.companyDailyViewModel.cellclickSubject sendNext:row];
}
@end
