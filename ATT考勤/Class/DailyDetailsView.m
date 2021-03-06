//
//  DailyDetailsView.m
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DailyDetailsView.h"
#import "DailyDetailsViewModel.h"
#import "DailyDetailsCellView.h"
#import "UserModel.h"
#import "DailyDetailsHeadView.h"
#import "DailyDetailsFootView.h"

@interface DailyDetailsView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) DailyDetailsViewModel *dailyDetailsViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) DailyDetailsHeadView *dailyDetailsHeadView;

@property(nonatomic,strong) DailyDetailsFootView *dailyDetailsFootView;

@end

@implementation DailyDetailsView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.dailyDetailsViewModel = (DailyDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.dailyDetailsHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:50]));
    }];
    [self.dailyDetailsFootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.dailyDetailsHeadView.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:90]));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.dailyDetailsFootView.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
        
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    [self addSubview:self.dailyDetailsHeadView];
    [self addSubview:self.tableView];
    [self addSubview:self.dailyDetailsFootView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [[self.dailyDetailsViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            self.dailyDetailsHeadView.dailyDetailsModel =  self.dailyDetailsViewModel.dailyDetailsModel;
            self.dailyDetailsFootView.dailyDetailsModel =  self.dailyDetailsViewModel.dailyDetailsModel;
        });
    }];
}


-(void)setBusDate:(NSString *)busDate{
    if (!busDate) {
        return;
    }
    _busDate = busDate;
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.dailyDetailsViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.dailyDetailsViewModel.userCode = user.userCode;
    
    self.dailyDetailsViewModel.busDate = busDate;
    [self.dailyDetailsViewModel.refreshDataCommand execute:nil];
}

-(void)h_loadData{
    
}

#pragma mark lazyload
-(DailyDetailsViewModel *)dailyDetailsViewModel{
    if (!_dailyDetailsViewModel) {
        _dailyDetailsViewModel = [[DailyDetailsViewModel alloc] init];
    }
    return _dailyDetailsViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DailyDetailsCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([DailyDetailsCellView class])]];
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dailyDetailsViewModel.dailyDetailsModel.cardDetaillist.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DailyDetailsCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([DailyDetailsCellView class])] forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.busDate = self.busDate;
    cell.cardDetaillist = self.dailyDetailsViewModel.dailyDetailsModel.cardDetaillist[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(DailyDetailsHeadView *)dailyDetailsHeadView{
    if (!_dailyDetailsHeadView) {
        _dailyDetailsHeadView = [[DailyDetailsHeadView alloc] init];
    }
    return _dailyDetailsHeadView;
}

-(DailyDetailsFootView *)dailyDetailsFootView{
    if (!_dailyDetailsFootView) {
        _dailyDetailsFootView = [[DailyDetailsFootView alloc] init];
    }
    return _dailyDetailsFootView;
}

@end
