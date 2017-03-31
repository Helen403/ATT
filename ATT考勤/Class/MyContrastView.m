//
//  MyContrastView.m
//  ATT考勤
//
//  Created by Helen on 17/3/29.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyContrastView.h"
#import "MyContrastViewModel.h"
#import "MyContrastCellView.h"
#import "UserModel.h"
#import "MyContrastModel.h"

@interface MyContrastView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) MyContrastViewModel *myContrastViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *pre;

@property(nonatomic,strong) UILabel *last;

@property(nonatomic,assign) CGFloat berSum;

@property(nonatomic,assign) CGFloat lastSum;

@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) NSString *sum;

@end

@implementation MyContrastView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.myContrastViewModel = (MyContrastViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.pre mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:10]);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.pre);
        make.left.equalTo(weakSelf.pre.mas_right).offset([self h_w:10]);
    }];
    
    [self.last mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.pre);
        make.left.equalTo(weakSelf.title.mas_right).offset([self h_w:10]);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
          make.top.equalTo(weakSelf.pre.mas_bottom).offset([self h_w:10]);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
        make.top.equalTo(weakSelf.line.mas_bottom).offset(0);
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = white_color;
    
    [self addSubview:self.pre];
    [self addSubview:self.title];
    [self addSubview:self.last];
    [self addSubview:self.line];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.myContrastViewModel.companyCode = companyCode;
    UserModel *user = getModel(@"user");
    self.myContrastViewModel.userCode =user.userCode;
    self.myContrastViewModel.cardMonth = [LSCoreToolCenter currentYearYM];
    [self.myContrastViewModel.refreshDataCommand execute:nil];
}

-(void)h_bindViewModel{
    [[self.myContrastViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSInteger count = self.myContrastViewModel.arrContrast.count;
            for(int i = 0;i<count;i++){
              MyContrastModel *myContrastModel =  self.myContrastViewModel.arrContrast[i];
                self.lastSum =self.lastSum+myContrastModel.curMonthHours.floatValue;
                self.berSum = self.berSum = myContrastModel.befMonthHours.floatValue;
            }

            self.last.text = [NSString stringWithFormat:@"本月平均:%.2f小时",self.lastSum/(float)[LSCoreToolCenter totaldaysInMonth:[NSDate date]]];
            self.sum = [NSString stringWithFormat:@"%.2f",self.lastSum/(float)[LSCoreToolCenter totaldaysInMonth:[NSDate date]]];
            self.title.text = [NSString stringWithFormat:@"上月平均:%.2f小时",self.berSum/(float)[LSCoreToolCenter getCurrentPreMonth:-1]];
            [self.tableView reloadData];
            
        });
       
    }];
}

#pragma mark lazyload
-(MyContrastViewModel *)myContrastViewModel{
    if (!_myContrastViewModel) {
        _myContrastViewModel = [[MyContrastViewModel alloc] init];
    }
    return _myContrastViewModel;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

-(UILabel *)pre{
    if (!_pre) {
        _pre = [[UILabel alloc] init];
        _pre.text = @"日期";
        _pre.font = H14;
        _pre.textColor = MAIN_PAN_2;
    }
    return _pre;
}

-(UILabel *)last{
    if (!_last) {
        _last = [[UILabel alloc] init];
        _last.text = @"本月平均:0.00小时";
        _last.font = H14;
        _last.textColor = MAIN_PAN_2;
    }
    return _last;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"上月平均:0.00小时,";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyContrastCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyContrastCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myContrastViewModel.arrContrast.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyContrastCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyContrastCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.average = self.sum;
    cell.myContrastModel = self.myContrastViewModel.arrContrast[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
}

@end
