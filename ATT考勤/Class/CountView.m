//
//  CountView.m
//  ATT考勤
//
//  Created by Helen on 17/1/12.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CountView.h"
#import "CheckViewModel.h"
#import "CountCellView.h"


@interface CountView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) CheckViewModel *checkViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIImageView *pre;

@property(nonatomic,strong) UIImageView *last;

@end

@implementation CountView


#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.checkViewModel = (CheckViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.pre mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:20]);
        make.top.equalTo([self h_w:7]);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.pre);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.last mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-[self h_w:20]);
        make.top.equalTo([self h_w:7]);
    }];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
        make.top.equalTo(weakSelf.pre.mas_bottom).offset([self h_w:7]);
    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = MAIN_ORANGER;
    
    [self addSubview:self.pre];
    [self addSubview:self.title];
    [self addSubview:self.last];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(CheckViewModel *)checkViewModel{
    if (!_checkViewModel) {
        _checkViewModel = [[CheckViewModel alloc] init];
    }
    return _checkViewModel;
}

-(UIImageView *)pre{
    if (!_pre) {
        _pre = [[UIImageView alloc] init];
        _pre.image = ImageNamed(@"icon_previous");
    }
    return _pre;
}

-(UIImageView *)last{
    if (!_last) {
        _last = [[UIImageView alloc] init];
        _last.image = ImageNamed(@"icon_next");
    }
    return _last;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"2016年12月2日";
        _title.font = H16;
        _title.textColor = white_color;
    }
    return _title;
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[CountCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CountCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.checkViewModel.arrCount.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CountCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CountCellView class])] forIndexPath:indexPath];
    
        cell.countModel = self.checkViewModel.arrCount[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
        [self.checkViewModel.cellclickSubject sendNext:row];
}

@end
