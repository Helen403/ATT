//
//  CompanyDailyDetailsView.m
//  ATT考勤
//
//  Created by Helen on 17/4/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CompanyDailyDetailsView.h"
#import "CompanyDailyDetailsViewModel.h"
#import "CompanyDailyDetailsCellView.h"
#import "CompanyDailyDetailsHeadView.h"


@interface CompanyDailyDetailsView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) CompanyDailyDetailsViewModel *companyDailyDetailsViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) CompanyDailyDetailsHeadView *companyDailyDetailsHeadView;

@end

@implementation CompanyDailyDetailsView
#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.companyDailyDetailsViewModel = (CompanyDailyDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.companyDailyDetailsHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:80]));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(weakSelf.companyDailyDetailsHeadView.mas_bottom).offset(0);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.companyDailyDetailsHeadView];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [[self.companyDailyDetailsViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            //            self.weekDetailsHeadView.endDate = self.endDate;
            //            self.weekDetailsHeadView.startDate = self.startDate;
            //            self.weekDetailsHeadView.weekHours = self.weekHours;
            [self.tableView reloadData];
            
        });
    }];
}


-(void)setCardDate:(NSString *)cardDate{
    if (!cardDate) {
        return;
    }
    _cardDate = cardDate;
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.companyDailyDetailsViewModel.companyCode = companyCode;
    

    self.companyDailyDetailsViewModel.cardDate = cardDate;
    
    [self.companyDailyDetailsViewModel.refreshDataCommand execute:nil];
    
    NSString *companyNickName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyNickName"];
    self.companyDailyDetailsHeadView.deptName = companyNickName;
}

-(void)h_loadData{
    
}

#pragma mark lazyload
-(CompanyDailyDetailsViewModel *)companyDailyDetailsViewModel{
    if (!_companyDailyDetailsViewModel) {
        _companyDailyDetailsViewModel = [[CompanyDailyDetailsViewModel alloc] init];
    }
    return _companyDailyDetailsViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[CompanyDailyDetailsCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyDailyDetailsCellView class])]];
        
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.companyDailyDetailsViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyDailyDetailsCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyDailyDetailsCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row;
    cell.companyDailyDetailsModel = self.companyDailyDetailsViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    //    [self.dealWithViewModel.cellclickSubject sendNext:row];
}


-(CompanyDailyDetailsHeadView *)companyDailyDetailsHeadView{
    if (!_companyDailyDetailsHeadView) {
        _companyDailyDetailsHeadView = [[CompanyDailyDetailsHeadView alloc] init];
    }
    return _companyDailyDetailsHeadView;
}


@end
