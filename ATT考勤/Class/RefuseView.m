//
//  RefuseView.m
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "RefuseView.h"
#import "RefuseViewModel.h"
#import "UserModel.h"
#import "RefuseCellView.h"

@interface RefuseView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) RefuseViewModel *refuseViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation RefuseView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.refuseViewModel = (RefuseViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.refuseViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.refuseViewModel.userCode = @"3";
    [self.refuseViewModel.refreshDataCommand execute:nil];
}


-(void)h_bindViewModel{
    [[self.refuseViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
    }];
}

#pragma mark lazyload


-(RefuseViewModel *)refuseViewModel{
    if (!_refuseViewModel) {
        _refuseViewModel = [[RefuseViewModel alloc] init];
    }
    return _refuseViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[RefuseCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([RefuseCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.refuseViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RefuseCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([RefuseCellView class])] forIndexPath:indexPath];
    
    cell.refuseModel = self.refuseViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:80];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.refuseViewModel.cellclickSubject sendNext:row];
}

@end
