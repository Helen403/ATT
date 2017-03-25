//
//  TeamRedBlackView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamRedBlackView.h"
#import "TeamRedBlackCellView.h"
#import "TeamRedBlackViewModel.h"



@interface TeamRedBlackView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) TeamRedBlackViewModel *teamRedBlackViewModel;

@property(nonatomic,strong) UITableView *tableView;



@end


@implementation TeamRedBlackView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.teamRedBlackViewModel = (TeamRedBlackViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
        
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [[self.teamRedBlackViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.teamRedBlackViewModel.companyCode = companyCode;
    [self.teamRedBlackViewModel.refreshDataCommand execute:nil];
}


#pragma mark lazyload
-(TeamRedBlackViewModel *)teamRedBlackViewModel{
    if (!_teamRedBlackViewModel) {
        _teamRedBlackViewModel = [[TeamRedBlackViewModel alloc] init];
    }
    return _teamRedBlackViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TeamRedBlackCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamRedBlackCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.teamRedBlackViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeamRedBlackCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamRedBlackCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.count = self.teamRedBlackViewModel.arr.count;
    cell.index = indexPath.row;
    cell.teamRedBlackModel = self.teamRedBlackViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:180];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.teamRedBlackViewModel.cellclickSubject sendNext:row];
}





@end
