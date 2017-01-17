//
//  AddressListView.m
//  ATT考勤
//
//  Created by Helen on 17/1/10.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AddressListView.h"
#import "AddressListViewModel.h"
#import "AddressListCellView.h"
#import "ToTeamView.h"

@interface AddressListView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) AddressListViewModel *addressListViewModel;

@property(nonatomic,strong) ToTeamView *toTeamView;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UISearchBar *searchBar;

@end

@implementation AddressListView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.addressListViewModel = (AddressListViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:30]));
    }];
    
    [self.toTeamView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(weakSelf.searchBar.mas_bottom).offset(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:40]));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(weakSelf.toTeamView.mas_bottom).offset([self h_w:1]);
        make.bottom.equalTo(0);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = GX_BGCOLOR;
    
    [self addSubview:self.searchBar];
    [self addSubview:self.toTeamView];
    
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(AddressListViewModel *)addressListViewModel{
    if (!_addressListViewModel) {
        _addressListViewModel = [[AddressListViewModel alloc] init];
    }
    return _addressListViewModel;
}


-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"姓名/手机号";
    }
    return _searchBar;
}

-(ToTeamView *)toTeamView{
    if (!_toTeamView) {
        _toTeamView = [[ToTeamView alloc] init];
        _toTeamView.backgroundColor = white_color;
        
        _toTeamView.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toTeam)];
        [_toTeamView addGestureRecognizer:setTap];
    }
    return _toTeamView;
}


-(void)toTeam{
    [self.addressListViewModel.teamclickSubject sendNext:nil];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[AddressListCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([AddressListCellView class])]];
        
    }
    return _tableView;
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.addressListViewModel.arr.count;
}

#pragma mark tableViewDataSource


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.addressListViewModel.cellclickSubject sendNext:row];
}




#pragma mark - delegate


#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressListCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AddressListCellView class])] forIndexPath:indexPath];
    
    cell.addressListModel = self.addressListViewModel.arr[indexPath.row];
    
    return cell;
}








@end
