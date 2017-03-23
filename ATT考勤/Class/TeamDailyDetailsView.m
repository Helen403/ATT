//
//  TeamDailyDetailsView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamDailyDetailsView.h"
#import "TeamDailyDetailsCellView.h"
#import "TeamDailyDetailsViewModel.h"
#import "TeamDailyDetailsHeadView.h"


@interface TeamDailyDetailsView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) TeamDailyDetailsViewModel *teamDailyDetailsViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) TeamDailyDetailsHeadView *teamDailyDetailsHeadView;

@end

@implementation TeamDailyDetailsView
#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.teamDailyDetailsViewModel = (TeamDailyDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.teamDailyDetailsHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:80]));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(weakSelf.teamDailyDetailsHeadView.mas_bottom).offset(0);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.teamDailyDetailsHeadView];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [[self.teamDailyDetailsViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
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
    
    self.teamDailyDetailsViewModel.companyCode = companyCode;
 
    self.teamDailyDetailsViewModel.deptCode = self.deptCode;
    self.teamDailyDetailsViewModel.cardDate = cardDate;
    
    [self.teamDailyDetailsViewModel.refreshDataCommand execute:nil];
    
    self.teamDailyDetailsHeadView.deptName = self.deptName;
}



-(void)h_loadData{
    
}

#pragma mark lazyload
-(TeamDailyDetailsViewModel *)teamDailyDetailsViewModel{
    if (!_teamDailyDetailsViewModel) {
        _teamDailyDetailsViewModel = [[TeamDailyDetailsViewModel alloc] init];
    }
    return _teamDailyDetailsViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TeamDailyDetailsCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamDailyDetailsCellView class])]];
        
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.teamDailyDetailsViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeamDailyDetailsCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamDailyDetailsCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row;
    cell.teamDailyDetailsModel = self.teamDailyDetailsViewModel.arr[indexPath.row];
    
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


-(TeamDailyDetailsHeadView *)teamDailyDetailsHeadView{
    if (!_teamDailyDetailsHeadView) {
        _teamDailyDetailsHeadView = [[TeamDailyDetailsHeadView alloc] init];
    }
    return _teamDailyDetailsHeadView;
}



@end
