
//
//  MonthDetailsView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MonthDetailsView.h"
#import "MonthDetailsViewModel.h"
#import "MonthDetailsCellView.h"
#import "UserModel.h"
#import "MonthDetailsHeadView.h"



@interface MonthDetailsView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) MonthDetailsViewModel *monthDetailsViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) MonthDetailsHeadView *monthDetailsHeadView;

@end

@implementation MonthDetailsView
#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.monthDetailsViewModel = (MonthDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.monthDetailsHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
           make.top.equalTo(0);
           make.right.equalTo(0);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:40]));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
         make.top.equalTo(weakSelf.monthDetailsHeadView.mas_bottom).offset(0);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.monthDetailsHeadView];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [[self.monthDetailsViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
//            self.weekDetailsHeadView.endDate = self.endDate;
//            self.weekDetailsHeadView.startDate = self.startDate;
//            self.weekDetailsHeadView.weekHours = self.weekHours;
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
    
    self.monthDetailsViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.monthDetailsViewModel.userCode = user.userCode;
    self.monthDetailsViewModel.startDate = self.startDate;
    self.monthDetailsViewModel.endDate = endDate;
    [self.monthDetailsViewModel.refreshDataCommand execute:nil];
}

-(void)h_loadData{
    
}

#pragma mark lazyload
-(MonthDetailsViewModel *)monthDetailsViewModel{
    if (!_monthDetailsViewModel) {
        _monthDetailsViewModel = [[MonthDetailsViewModel alloc] init];
    }
    return _monthDetailsViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MonthDetailsCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MonthDetailsCellView class])]];
        
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.monthDetailsViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MonthDetailsCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MonthDetailsCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row;
    cell.monthDetailsModel = self.monthDetailsViewModel.arr[indexPath.row];
    
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


-(MonthDetailsHeadView *)monthDetailsHeadView{
    if (!_monthDetailsHeadView) {
        _monthDetailsHeadView = [[MonthDetailsHeadView alloc] init];
    }
    return _monthDetailsHeadView;
}
@end
