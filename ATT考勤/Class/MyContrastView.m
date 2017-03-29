//
//  MyContrastView.m
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyContrastView.h"
#import "MyContrastViewModel.h"
#import "MyContrastCellView.h"



@interface MyContrastView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) MyContrastViewModel *myContrastViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIImageView *pre;

@property(nonatomic,strong) UIImageView *last;

@end

@implementation MyContrastView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.myContrastViewModel = (MyContrastViewModel *)viewModel;
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
-(MyContrastViewModel *)myContrastViewModel{
    if (!_myContrastViewModel) {
        _myContrastViewModel = [[MyContrastViewModel alloc] init];
    }
    return _myContrastViewModel;
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
        [_tableView registerClass:[MyContrastCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyContrastCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myContrastViewModel.arrContrast.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyContrastCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyContrastCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myContrastModel = self.myContrastViewModel.arrContrast[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
}

@end
