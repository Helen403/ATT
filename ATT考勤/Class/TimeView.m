//
//  TimeView.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TimeView.h"
#import "TimeViewModel.h"
#import "TimeCellView.h"

@interface TimeView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) TimeViewModel *timeViewModel;

@property(nonatomic,strong) UITableView *tableView;


@end

@implementation TimeView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.timeViewModel = (TimeViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [super updateConstraints];
}


-(void)h_setupViews{
    
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(TimeViewModel *)timeViewModel{
    if (!_timeViewModel) {
        _timeViewModel = [[TimeViewModel alloc] init];
    }
    return _timeViewModel;
    
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TimeCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TimeCellView class])]];
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.timeViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TimeCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TimeCellView class])] forIndexPath:indexPath];
    
    cell.timeModel = self.timeViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       TimeCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TimeCellView class])] forIndexPath:indexPath];
    cell.selected = NO;
    cell.timeModel = self.timeViewModel.arr[indexPath.row];
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.timeViewModel.cellclickSubject sendNext:row];
}

@end
