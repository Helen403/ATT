
//
//  MeView.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MeApplyView.h"
#import "MeApplyViewModel.h"
#import "MeApplyCellView.h"

@interface MeApplyView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) MeApplyViewModel *meApplyViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation MeApplyView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    self.meApplyViewModel = (MeApplyViewModel *)viewModel;
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
-(MeApplyViewModel *)meApplyViewModel{
    if (!_meApplyViewModel) {
        _meApplyViewModel = [[MeApplyViewModel alloc] init];
    }
    return _meApplyViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MeApplyCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MeApplyCellView class])]];
        
        
    }
    return _tableView;
    
}

#pragma mark - delegate
#pragma mark tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.meApplyViewModel.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MeApplyCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MeApplyCellView class])] forIndexPath:indexPath];
    
    cell.meApplyModel = self.meApplyViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MeApplyCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MeApplyCellView class])] forIndexPath:indexPath];
    cell.selected = NO;
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.meApplyViewModel.cellclickSubject sendNext:row];
}

@end
