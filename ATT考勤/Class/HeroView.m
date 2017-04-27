//
//  HeroView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "HeroView.h"
#import "HeroViewModel.h"
#import "HeroCellView.h"
#import "HeroHeadView.h"
#import "HeroModel.h"

@interface HeroView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) HeroViewModel *heroViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) HeroHeadView *heroHeadView;

@end


@implementation HeroView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.heroViewModel = (HeroViewModel *)viewModel;
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

-(void)h_bindViewModel{
    [[self.heroViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.heroViewModel.companyCode = companyCode;
    [self.heroViewModel.refreshDataCommand execute:nil];
}


#pragma mark lazyload
-(HeroViewModel *)heroViewModel{
    if (!_heroViewModel) {
        _heroViewModel = [[HeroViewModel alloc] init];
    }
    return _heroViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[HeroCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([HeroCellView class])]];
        _tableView.tableHeaderView = self.heroHeadView;
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.heroViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HeroCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([HeroCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row;
    HeroModel *heroModel = self.heroViewModel.arr[indexPath.row];
    cell.heroModel = heroModel;
    NSString *empName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"empName"];
    if ([empName isEqualToString:heroModel.empName]) {
        self.heroHeadView.index = indexPath.row+1;
        self.heroHeadView.heroModel = heroModel;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:60];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.heroViewModel.cellclickSubject sendNext:row];
}

-(HeroHeadView *)heroHeadView{
    if (!_heroHeadView) {
        _heroHeadView = [[HeroHeadView alloc] init];
        _heroHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self h_w:200]);
//        [_heroHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:140]));
//        }];
    }
    return _heroHeadView;
}

@end
