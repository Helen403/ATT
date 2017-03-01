//
//  Approve.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ApproveView.h"
#import "ApproveCellView.h"
#import "ApproveViewModel.h"

@interface ApproveView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) ApproveViewModel *approveViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ApproveView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    self.approveViewModel = (ApproveViewModel *)viewModel;
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
-(ApproveViewModel *)approveViewModel{
    if (!_approveViewModel) {
        _approveViewModel = [[ApproveViewModel alloc] init];
    }
    return _approveViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ApproveCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ApproveCellView class])]];
        
        
    }
    return _tableView;
}



#pragma mark - delegate
#pragma mark tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.approveViewModel.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ApproveCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ApproveCellView class])] forIndexPath:indexPath];
    
    cell.approveModel = self.approveViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ApproveCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ApproveCellView class])] forIndexPath:indexPath];
    
    cell.approveModel = self.approveViewModel.arr[indexPath.row];
    cell.selected = NO;
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.approveViewModel.cellclickSubject sendNext:row];
}

@end
