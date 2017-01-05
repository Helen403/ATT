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

@interface MineView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) MineViewModel *mineViewModel;

@property(nonatomic,strong) UITableView *tableView;

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
    
    return 7;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MineCellView class])] forIndexPath:indexPath];
    
    cell.mineModel = self.mineViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.mineViewModel.cellclickSubject sendNext:row];
}






@end
