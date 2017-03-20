//
//  AlreadyTreatmentView.m
//  ATT考勤
//
//  Created by Helen on 17/3/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AlreadyTreatmentView.h"
#import "AlreadyTreatmentViewModel.h"
#import "UserModel.h"
#import "AlreadyTreatmentCellView.h"

@interface AlreadyTreatmentView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) AlreadyTreatmentViewModel *alreadyTreatmentViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation AlreadyTreatmentView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.alreadyTreatmentViewModel = (AlreadyTreatmentViewModel *)viewModel;
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
    
    self.alreadyTreatmentViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.alreadyTreatmentViewModel.userCode = @"3";
    [self.alreadyTreatmentViewModel.refreshDataCommand execute:nil];
}


-(void)h_bindViewModel{
    [[self.alreadyTreatmentViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
    }];
}

#pragma mark lazyload


-(AlreadyTreatmentViewModel *)alreadyTreatmentViewModel{
    if (!_alreadyTreatmentViewModel) {
        _alreadyTreatmentViewModel = [[AlreadyTreatmentViewModel alloc] init];
    }
    return _alreadyTreatmentViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[AlreadyTreatmentCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([AlreadyTreatmentCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.alreadyTreatmentViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AlreadyTreatmentCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AlreadyTreatmentCellView class])] forIndexPath:indexPath];
    
    cell.alreadyTreatmentModel = self.alreadyTreatmentViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:80];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.alreadyTreatmentViewModel.cellclickSubject sendNext:row];
}

@end
