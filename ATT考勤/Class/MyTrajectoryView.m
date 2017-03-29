//
//  MyTrajectoryView.m
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyTrajectoryView.h"
#import "MyTrajectoryViewModel.h"
#import "MyTrajectoryCellView.h"

#import "UserModel.h"

@interface MyTrajectoryView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) MyTrajectoryViewModel *myTrajectoryViewModel;

@property(nonatomic,strong) UITableView *tableView;



@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UILabel *pre;

@property(nonatomic,strong) UILabel *last;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIView *line2;


@property(nonatomic,assign) NSInteger index;

@end

@implementation MyTrajectoryView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.myTrajectoryViewModel = (MyTrajectoryViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.pre mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:10]);
    }];
    
    CGSize size = [LSCoreToolCenter getSizeWithText:@"2017年12月" fontSize:14];
    CGFloat leftPadding;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        leftPadding = (SCREEN_WIDTH -size.width)*0.5;
    } else {
        leftPadding = (SCREEN_WIDTH -size.width*2)*0.5;
    }
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.top.equalTo(weakSelf.pre);
    }];
    
    [self.last mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pre);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pre.mas_bottom).offset(10);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
        make.top.equalTo(weakSelf.pre.mas_bottom).offset([self h_w:7]);
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = white_color;
    [self addSubview:self.line1];
    [self addSubview:self.pre];
    [self addSubview:self.title];
    [self addSubview:self.last];
    [self addSubview:self.line2];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_loadData{
    self.index = 0;
    self.title.text = [LSCoreToolCenter getCurrentMonthTitle:self.index];
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.myTrajectoryViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.myTrajectoryViewModel.userCode = user.userCode;
    self.myTrajectoryViewModel.cardMonth = [LSCoreToolCenter currentYearYM];
    [self.myTrajectoryViewModel.trajectoryCommand execute:nil];
}


-(void)h_bindViewModel{
    [[self.myTrajectoryViewModel.trajectorySubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
        
    }];
}


#pragma mark lazyload
-(MyTrajectoryViewModel *)myTrajectoryViewModel{
    if (!_myTrajectoryViewModel) {
        _myTrajectoryViewModel = [[MyTrajectoryViewModel alloc] init];
    }
    return _myTrajectoryViewModel;
}

-(UILabel *)pre{
    if (!_pre) {
        _pre = [[UILabel alloc] init];
        _pre.text = @"< 上月";
        _pre.font = H14;
        _pre.textColor = MAIN_PAN_2;
        _pre.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(preClick)];
        [_pre addGestureRecognizer:setTap];
    }
    return _pre;
}

-(void)preClick{
    --self.index;
    ShowMaskStatus(@"正在拼命加载");
    self.title.text = [LSCoreToolCenter getCurrentMonthTitle:self.index];
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.myTrajectoryViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.myTrajectoryViewModel.userCode = user.userCode;
    self.myTrajectoryViewModel.cardMonth = [LSCoreToolCenter getCurrentYMonth:self.index];
    [self.myTrajectoryViewModel.trajectoryCommand execute:nil];
    
}

-(void)lastClick{
    ++self.index;
    ShowMaskStatus(@"正在拼命加载");
    self.title.text = [LSCoreToolCenter getCurrentMonthTitle:self.index];
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.myTrajectoryViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.myTrajectoryViewModel.userCode = user.userCode;
    self.myTrajectoryViewModel.cardMonth = [LSCoreToolCenter getCurrentYMonth:self.index];
    [self.myTrajectoryViewModel.trajectoryCommand execute:nil];
    
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UILabel *)last{
    if (!_last) {
        _last = [[UILabel alloc] init];
        _last.text = @"下月 >";
        _last.font = H14;
        _last.textColor = MAIN_PAN_2;
        _last.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lastClick)];
        [_last addGestureRecognizer:setTap];
    }
    return _last;
}
-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line2;
}

-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line1;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyTrajectoryCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyTrajectoryCellView class])]];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.15)];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myTrajectoryViewModel.arrTrajectory.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyTrajectoryCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyTrajectoryCellView class])] forIndexPath:indexPath];
    
    cell.myTrajectoryModel = self.myTrajectoryViewModel.arrTrajectory[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:110];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}


@end
