//
//  CompanyMonthView.m
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CompanyMonthView.h"
#import "CompanyMonthViewModel.h"
#import "CompanyMonthCellView.h"


@interface CompanyMonthView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) CompanyMonthViewModel *companyMonthViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end


@implementation CompanyMonthView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.companyMonthViewModel = (CompanyMonthViewModel *)viewModel;
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
    [[self.companyMonthViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.companyMonthViewModel.companyCode = companyCode;
   
    
    [self.companyMonthViewModel.refreshDataCommand execute:nil];
}


#pragma mark lazyload
-(CompanyMonthViewModel *)companyMonthViewModel{
    if (!_companyMonthViewModel) {
        _companyMonthViewModel = [[CompanyMonthViewModel alloc] init];
    }
    return _companyMonthViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[CompanyMonthCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyMonthCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.companyMonthViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyMonthCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyMonthCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.companyMonthModel = self.companyMonthViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyMonthCellView class])] cacheByIndexPath:indexPath configuration:^(CompanyMonthCellView *cell) {
        cell.companyMonthModel = self.companyMonthViewModel.arr[indexPath.row];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.companyMonthViewModel.cellclickSubject sendNext:row];
}


@end
