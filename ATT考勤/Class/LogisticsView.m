//
//  LogisticsView.m
//  ATT考勤
//
//  Created by Helen on 16/12/28.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "LogisticsView.h"
#import "PendingCellView.h"
#import "PendingCellViewModel.h"

@interface LogisticsView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) PendingCellViewModel *pendingCellViewModel;

@end

@implementation LogisticsView
#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{

    self.pendingCellViewModel = (PendingCellViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
        make.top.equalTo(3);
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
    
}


#pragma mark lazyload
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[PendingCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([PendingCellView class])]];
        
        
    }
    return _tableView;
    
}

#pragma mark - delegate
#pragma mark tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PendingCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([PendingCellView class])] forIndexPath:indexPath];
    
    cell.pendingModel = self.pendingCellViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.pendingCellViewModel.cellclickSubject sendNext:row];
}


-(PendingCellViewModel *)pendingCellViewModel{
    if (!_pendingCellViewModel) {
        _pendingCellViewModel = [[PendingCellViewModel alloc] init];
    }
    return _pendingCellViewModel;

}


@end
