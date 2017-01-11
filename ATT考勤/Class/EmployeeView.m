//
//  EmployeeView.m
//  ATT考勤
//
//  Created by Helen on 17/1/10.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "EmployeeView.h"
#import "EmployeeViewModel.h"
#import "EmployeeCellView.h"
#import "EmployeeHeadView.h"


@interface EmployeeView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) EmployeeViewModel *employeeViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) EmployeeHeadView *employeeHeadView;

@end


@implementation EmployeeView


#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.employeeViewModel = (EmployeeViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    
    [self.employeeHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo([self h_w:0]);
        make.right.equalTo(-[self h_w:0]);
        make.top.equalTo([self h_w:0]);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:140]));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
          make.top.equalTo(weakSelf.employeeHeadView.mas_bottom).offset([self h_w:0]);
        make.left.equalTo([self h_w:0]);
        make.right.equalTo(-[self h_w:0]);
        make.bottom.equalTo([self h_w:0]);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.employeeHeadView];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(EmployeeHeadView *)employeeHeadView{
    if (!_employeeHeadView) {
        _employeeHeadView = [[EmployeeHeadView alloc] init];
    }
    return _employeeHeadView;
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[EmployeeCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([EmployeeCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.employeeViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EmployeeCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([EmployeeCellView class])] forIndexPath:indexPath];
    
    cell.employeeModel = self.employeeViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.employeeViewModel.cellclickSubject sendNext:row];
}

@end
