//
//  LateTreatmentView.m
//  ATT考勤
//
//  Created by Helen on 17/3/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "LateTreatmentView.h"
#import "LateTreatmentViewModel.h"
#import "LateTreatmentCellView.h"
#import "UserModel.h"

@interface LateTreatmentView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) LateTreatmentViewModel *lateTreatmentViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation LateTreatmentView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.lateTreatmentViewModel = (LateTreatmentViewModel *)viewModel;
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
    
    self.lateTreatmentViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.lateTreatmentViewModel.userCode = user.userCode;
    [self.lateTreatmentViewModel.refreshDataCommand execute:nil];
}


-(void)h_bindViewModel{
    [[self.lateTreatmentViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
    }];
}

#pragma mark lazyload
-(LateTreatmentViewModel *)lateTreatmentViewModel{
    if (!_lateTreatmentViewModel) {
        _lateTreatmentViewModel = [[LateTreatmentViewModel alloc] init];
    }
    return _lateTreatmentViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LateTreatmentCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([LateTreatmentCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.lateTreatmentViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LateTreatmentCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([LateTreatmentCellView class])] forIndexPath:indexPath];
    
    cell.lateTreatmentModel = self.lateTreatmentViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:80];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    //    [self.dealWithViewModel.cellclickSubject sendNext:row];
}



@end
