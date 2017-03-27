//
//  NoticeListView.m
//  ATT考勤
//
//  Created by Helen on 17/3/27.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "NoticeListView.h"
#import "NoticeListViewModel.h"
#import "NoticeListCellView.h"
#import "UserModel.h"

@interface NoticeListView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NoticeListViewModel *noticeListViewModel;

@end

@implementation NoticeListView


#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.noticeListViewModel = (NoticeListViewModel *)viewModel;
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

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.noticeListViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.noticeListViewModel.userCode = user.userCode;
    [self.noticeListViewModel.refreshDataCommand execute:nil];
}

-(void)h_bindViewModel{
    [[self.noticeListViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark lazyload
-(NoticeListViewModel *)noticeListViewModel{
    if (!_noticeListViewModel) {
        _noticeListViewModel = [[NoticeListViewModel alloc] init];
    }
    return _noticeListViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[NoticeListCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([NoticeListCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.noticeListViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NoticeListCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([NoticeListCellView class])] forIndexPath:indexPath];
    cell.index = indexPath.row;
    cell.noticeListModel = self.noticeListViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.noticeListViewModel.cellclickSubject sendNext:row];
}

@end
