//
//  TimeSoundView.m
//  ATT考勤
//
//  Created by Helen on 17/3/13.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TimeSoundView.h"
#import "TimeSoundCellView.h"
#import "TimeSoundViewModel.h"

@interface TimeSoundView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) TimeSoundViewModel *timeSoundViewModel;

@end

@implementation TimeSoundView

#pragma mark system

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.timeSoundViewModel = (TimeSoundViewModel *)viewModel;
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

#pragma mark lazyload

-(TimeSoundViewModel *)timeSoundViewModel{
    if (!_timeSoundViewModel) {
        _timeSoundViewModel = [[TimeSoundViewModel alloc] init];
    }
    return _timeSoundViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TimeSoundCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TimeSoundCellView class])]];
        _tableView.scrollEnabled = NO;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self h_w:40])];
        view.backgroundColor = white_color;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake([self h_w:10], 0, SCREEN_WIDTH, [self h_w:40])];
        title.text = @"请选择";
        title.font = H14;
        title.textColor = MAIN_PAN_2;
        [view addSubview:title];
        title.centerY = [self h_w:20];
        _tableView.tableHeaderView = view;
        ViewRadius(_tableView, 5);
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.timeSoundViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TimeSoundCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TimeSoundCellView class])] forIndexPath:indexPath];
    
    cell.timeSoundModel = self.timeSoundViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [[HWPopTool sharedInstance] closeWithBlcok:^{
        TimeSoundModel *timeSound = self.timeSoundViewModel.arr[indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:timeSound.title forKey:@"Sound"];
        self.clickBlock(0);
    }];
}


@end
