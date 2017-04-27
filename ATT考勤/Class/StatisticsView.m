//
//  StatisticsView.m
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "StatisticsView.h"
#import "StatisticsViewModel.h"
#import "StatisticsCellView.h"
#import "UserModel.h"

@interface StatisticsView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) StatisticsViewModel *statisticsViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation StatisticsView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.statisticsViewModel = (StatisticsViewModel *)viewModel;
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

-(void)h_viewWillAppear{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.statisticsViewModel.companyCode = companyCode;
    UserModel *user = getModel(@"user");
    self.statisticsViewModel.userCode = user.userCode;
    [self.statisticsViewModel.refreshDataCommand execute:nil];
}


-(void)h_bindViewModel{

    [[self.statisticsViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
}

#pragma mark lazyload
-(StatisticsViewModel *)statisticsViewModel{
    if (!_statisticsViewModel) {
        _statisticsViewModel = [[StatisticsViewModel alloc] init];
    }
    return _statisticsViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[StatisticsCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([StatisticsCellView class])]];
        
    }
    return _tableView;
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else if(section == 1){
        if (!self.statisticsViewModel.userAuthorModel) {
            int count = 0;
            if([self.statisticsViewModel.userAuthorModel.isReportDeptDay isEqualToString:@"1"]){
                count = count + 1;
            }
            if([self.statisticsViewModel.userAuthorModel.isReportDeptWeek isEqualToString:@"1"]){
                count = count + 1;
            }
            if([self.statisticsViewModel.userAuthorModel.isReportDeptMonth isEqualToString:@"1"]){
                count = count + 1;
            }
            if([self.statisticsViewModel.userAuthorModel.isReportDeptOut isEqualToString:@"1"]){
                count = count + 1;
            }
            return count;
        }else{
            return 0;
        }

    }else if(section == 2){
        if (!self.statisticsViewModel.userAuthorModel) {
            int count = 0;
            if([self.statisticsViewModel.userAuthorModel.isReportCompanyDay isEqualToString:@"1"]){
                count = count + 1;
            }
            if([self.statisticsViewModel.userAuthorModel.isReportCompanyWeek isEqualToString:@"1"]){
                count = count + 1;
            }
            if([self.statisticsViewModel.userAuthorModel.isReportCompanyMonth isEqualToString:@"1"]){
                count = count + 1;
            }
            return count;
        }else{
            return 0;
        }

    }else{
        return 3;
    }
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StatisticsCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([StatisticsCellView class])] forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.statisticsModel = self.statisticsViewModel.arr[indexPath.row];
    }else if(indexPath.section == 1){
        if (!self.statisticsViewModel.userAuthorModel) {
            
            if([self.statisticsViewModel.userAuthorModel.isReportDeptDay isEqualToString:@"1"]&& indexPath.row ==6 ){
               cell.statisticsModel = self.statisticsViewModel.arr[6];
            }
            if([self.statisticsViewModel.userAuthorModel.isReportDeptWeek isEqualToString:@"1"]&& indexPath.row ==7){
               cell.statisticsModel = self.statisticsViewModel.arr[7];
            }
            if([self.statisticsViewModel.userAuthorModel.isReportDeptMonth isEqualToString:@"1"]&& indexPath.row ==8){
               cell.statisticsModel = self.statisticsViewModel.arr[8];
            }
            if([self.statisticsViewModel.userAuthorModel.isReportDeptOut isEqualToString:@"1"]&& indexPath.row ==9){
               cell.statisticsModel = self.statisticsViewModel.arr[9];
            }
        }
        
     
    }else if(indexPath.section == 2){
        if([self.statisticsViewModel.userAuthorModel.isReportCompanyDay isEqualToString:@"1"]&&indexPath.row == 10){
              cell.statisticsModel = self.statisticsViewModel.arr[10];
        }
        if([self.statisticsViewModel.userAuthorModel.isReportCompanyWeek isEqualToString:@"1"]&&indexPath.row == 11){
            cell.statisticsModel = self.statisticsViewModel.arr[11];
        }
        if([self.statisticsViewModel.userAuthorModel.isReportCompanyMonth isEqualToString:@"1"]&&indexPath.row ==12){
           cell.statisticsModel = self.statisticsViewModel.arr[12];
        }
        
    }else{
        cell.statisticsModel = self.statisticsViewModel.arr[indexPath.row+12];

    }
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSNumber *row;
    if (indexPath.section == 0) {
        row = [NSNumber numberWithInteger:indexPath.row];
    }else if(indexPath.section == 1){
        row = [NSNumber numberWithInteger:indexPath.row+5];
    }else if(indexPath.section == 2){
        
        row = [NSNumber numberWithInteger:indexPath.row+9];
        
        
    }else{
        row = [NSNumber numberWithInteger:indexPath.row+12];
    }

    [self.statisticsViewModel.cellclickSubject sendNext:row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self h_w:40];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = BG_COLOR;
    UILabel *text = [[UILabel alloc] init];
    text.font = H14;
    text.textColor = MAIN_PAN_2;
    if (section == 0) {
        text.text = @"我的报表";
    }else if(section == 1){
        text.text = @"部门报表";
    }else if(section == 2){
        text.text = @"公司报表";
    }else{
        text.text = @"英雄榜";
    }
    
    text.frame = CGRectMake([self h_w:10], 0, SCREEN_WIDTH, [self h_w:40]);
    [headView addSubview:text];
    return headView;
}


@end
