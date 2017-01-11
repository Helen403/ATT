//
//  PersonalView.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "PersonalView.h"
#import "PersonalViewModel.h"
#import "PersonalHeadView.h"
#import "PersonalCellView.h"

@interface PersonalView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) PersonalViewModel *personalViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) PersonalHeadView *personalHeadView;

@end

@implementation PersonalView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.personalViewModel = (PersonalViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.personalHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:160]));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.personalHeadView.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.personalHeadView];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(PersonalHeadView *)personalHeadView{
    if (!_personalHeadView) {
        _personalHeadView = [[PersonalHeadView alloc] init];
        _personalHeadView.backgroundColor = MAIN_GRAY;
    }
    return _personalHeadView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[PersonalCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([PersonalCellView class])]];
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.personalViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([PersonalCellView class])] forIndexPath:indexPath];
    
        cell.personalModel = self.personalViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
     [self.personalViewModel.cellclickSubject sendNext:row];
}

@end
