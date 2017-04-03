//
//  SignView.m
//  ATT考勤
//
//  Created by Helen on 17/3/23.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "SignView.h"
#import "SignViewModel.h"
#import "SignCellView.h"
#import "SignHeadView.h"


@interface SignView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) SignViewModel *signViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) SignHeadView *signHeadView;

@end


@implementation SignView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.signViewModel = (SignViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.signHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:90]));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(weakSelf.signHeadView.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
         make.bottom.equalTo(0);
        
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.signHeadView];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [[self.signViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.signViewModel.companyCode = companyCode;
    self.signViewModel.cardDate = [LSCoreToolCenter getCurrentTimeYMD];
    [self.signViewModel.refreshDataCommand execute:nil];
}


#pragma mark lazyload
-(SignViewModel *)signViewModel{
    if (!_signViewModel) {
        _signViewModel = [[SignViewModel alloc] init];
    }
    return _signViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SignCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([SignCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.signViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SignCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([SignCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row;
    cell.signModel = self.signViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.signViewModel.cellclickSubject sendNext:row];
}

-(SignHeadView *)signHeadView{
    if (!_signHeadView) {
        _signHeadView = [[SignHeadView alloc] init];
    }
    return _signHeadView;
}

@end
