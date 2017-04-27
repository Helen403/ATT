//
//  CompanyWeekView.m
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CompanyWeekView.h"
#import "CompanyWeekViewModel.h"
#import "CompanyWeekCellView.h"

@interface CompanyWeekView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) CompanyWeekViewModel *companyWeekViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end


@implementation CompanyWeekView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.companyWeekViewModel = (CompanyWeekViewModel *)viewModel;
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
    [[self.companyWeekViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.companyWeekViewModel.companyCode = companyCode;
    
    [self.companyWeekViewModel.refreshDataCommand execute:nil];
}


#pragma mark lazyload
-(CompanyWeekViewModel *)companyWeekViewModel{
    if (!_companyWeekViewModel) {
        _companyWeekViewModel = [[CompanyWeekViewModel alloc] init];
    }
    return _companyWeekViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[CompanyWeekCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyWeekCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.companyWeekViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyWeekCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyWeekCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.companyWeekModel = self.companyWeekViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyWeekCellView class])] cacheByIndexPath:indexPath configuration:^(CompanyWeekCellView *cell) {
        cell.companyWeekModel = self.companyWeekViewModel.arr[indexPath.row];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.companyWeekViewModel.cellclickSubject sendNext:row];
}

@end
