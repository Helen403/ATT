//
//  WeekDetailsView.m
//  ATT考勤
//
//  Created by Helen on 17/3/22.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "WeekDetailsView.h"
#import "WeekDetailsViewModel.h"
#import "WeekDetailsCellView.h"
#import "UserModel.h"
#import "WeekDetailsHeadView.h"


@interface WeekDetailsView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) WeekDetailsViewModel *weekDetailsViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) WeekDetailsHeadView *weekDetailsHeadView;

@end

@implementation WeekDetailsView
#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.weekDetailsViewModel = (WeekDetailsViewModel *)viewModel;
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
    [[self.weekDetailsViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.weekDetailsHeadView.endDate = self.endDate;
            self.weekDetailsHeadView.startDate = self.startDate;
            self.weekDetailsHeadView.weekHours = self.weekHours;
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
    
    self.weekDetailsViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.weekDetailsViewModel.userCode = user.userCode;
    self.weekDetailsViewModel.startDate = self.startDate;
    self.weekDetailsViewModel.endDate = endDate;
    [self.weekDetailsViewModel.refreshDataCommand execute:nil];
}

-(void)h_loadData{
   
}

#pragma mark lazyload
-(WeekDetailsViewModel *)weekDetailsViewModel{
    if (!_weekDetailsViewModel) {
        _weekDetailsViewModel = [[WeekDetailsViewModel alloc] init];
    }
    return _weekDetailsViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[WeekDetailsCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([WeekDetailsCellView class])]];
        _tableView.scrollEnabled = NO;
        _tableView.tableHeaderView = self.weekDetailsHeadView;
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.weekDetailsViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeekDetailsCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([WeekDetailsCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row;
    cell.weekDetalisModel = self.weekDetailsViewModel.arr[indexPath.row];
    
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


-(WeekDetailsHeadView *)weekDetailsHeadView{
    if (!_weekDetailsHeadView) {
        _weekDetailsHeadView = [[WeekDetailsHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self h_w:40])];
    }
    return _weekDetailsHeadView;
}

@end
