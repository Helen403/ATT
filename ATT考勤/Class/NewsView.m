//
//  NewsView.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "NewsView.h"
#import "NewsViewModel.h"
#import "NewCellView.h"

@interface NewsView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NewsViewModel *newsViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation NewsView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.newsViewModel = (NewsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(1);
        make.bottom.equalTo(0);
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
-(NewsViewModel *)newsViewModel{
    if (!_newsViewModel) {
        _newsViewModel = [[NewsViewModel alloc] init];
    }
    return _newsViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[NewCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([NewCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.newsViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([NewCellView class])] forIndexPath:indexPath];
    
    cell.newsModel = self.newsViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.newsViewModel.cellclickSubject sendNext:row];
}

@end
