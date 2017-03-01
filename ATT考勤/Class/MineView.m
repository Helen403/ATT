//
//  MineView.m
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MineView.h"
#import "MineViewModel.h"
#import "MineCellView.h"
#import "UserModel.h"

@interface MineView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) MineViewModel *mineViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UserModel *userModel;

@end

@implementation MineView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.mineViewModel = (MineViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(3);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
    [super updateConstraints];
}


-(void)h_setupViews{

    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [[self.mineViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {

        dispatch_sync(dispatch_get_main_queue(), ^{
             self.userModel = getModel(@"user");
            [self.tableView reloadData];
        });
    }];
    
    [[self.mineViewModel.successSignSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
           
            [self.tableView reloadData];
        });
    }];
    
}


-(void)h_loadData{
    self.userModel = getModel(@"user");
    self.mineViewModel.userCode = self.userModel.userCode;
    [self.mineViewModel.findSignCommand execute:nil];
    [self.mineViewModel.cardScoreCommand execute:nil];
    [self.mineViewModel.myHoldaysCommand execute:nil];
   
}

-(void)h_refreash{
    self.userModel = getModel(@"user");
    self.mineViewModel.telphone = self.userModel.userTelphone;
    [self.mineViewModel.refreshDataCommand execute:nil];
    [self.mineViewModel.findSignCommand execute:nil];
    [self.mineViewModel.cardScoreCommand execute:nil];
    [self.mineViewModel.myHoldaysCommand execute:nil];
}


#pragma mark lazyload
-(MineViewModel *)mineViewModel{
    if (!_mineViewModel) {
        _mineViewModel = [[MineViewModel alloc] init];
    }
    return _mineViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MineCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MineCellView class])]];
        //设置tableview 不能滚动
        _tableView.scrollEnabled =NO;
    }
    return _tableView;
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mineViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MineCellView class])] forIndexPath:indexPath];
    
    cell.mineModel = self.mineViewModel.arr[indexPath.row];
    cell.index = indexPath.row;
    cell.userModel = self.userModel;
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MineCellView class])] forIndexPath:indexPath];
    cell.selected = NO;
    cell.mineModel = self.mineViewModel.arr[indexPath.row];
    cell.index = indexPath.row;
    cell.userModel = self.userModel;
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.mineViewModel.cellclickSubject sendNext:row];
}


@end
