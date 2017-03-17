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

@property(nonatomic,strong) EmployeeModel *model;

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
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:180]));
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

-(void)h_loadData{
  [self.employeeViewModel.refreshDataCommand execute:nil];

}

-(void)h_bindViewModel{
    [[self.employeeViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *xmlDoc) {
        
        [self performSelectorOnMainThread:@selector(mainThread:) withObject:xmlDoc waitUntilDone:YES];
        
    }];
}

-(void)mainThread:(NSString *)xmlDoc{
    EmployeeModel *model = [LSCoreToolCenter initWithXMLString:xmlDoc object:[[EmployeeModel alloc] init]];
    
    self.model = model;
    [self.tableView reloadData];
    
}

-(void)setModel:(EmployeeModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    self.employeeHeadView.employeeModel = model;
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
        _tableView.scrollEnabled = NO;
        
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.employeeModel = self.model;
    cell.employeeTitle = self.employeeViewModel.arr[indexPath.row];
    cell.index = indexPath.row;
    cell.show.tag = indexPath.row;
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:80];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
//    [self.employeeViewModel.cellclickSubject sendNext:row];
}

@end
