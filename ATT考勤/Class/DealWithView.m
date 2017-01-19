//
//  DealWithView.m
//  ATT考勤
//
//  Created by Helen on 16/12/29.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "DealWithView.h"
#import "DealWithViewModel.h"
#import "DealWithCellView.h"

@interface DealWithView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) DealWithViewModel *dealWithViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation DealWithView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    self.dealWithViewModel = (DealWithViewModel *)viewModel;
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
    
    self.backgroundColor = GX_BGCOLOR;
    
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}



#pragma mark lazyload
-(DealWithViewModel *)dealWithViewModel{
    if (!_dealWithViewModel) {
        _dealWithViewModel = [[DealWithViewModel alloc] init];
    }
    return _dealWithViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DealWithCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([DealWithCellView class])]];
        
        
    }
    return _tableView;
    
}



#pragma mark - delegate
#pragma mark tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dealWithViewModel.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DealWithCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([DealWithCellView class])] forIndexPath:indexPath];
    
    cell.dealWithModel = self.dealWithViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.dealWithViewModel.cellclickSubject sendNext:row];
}



@end
