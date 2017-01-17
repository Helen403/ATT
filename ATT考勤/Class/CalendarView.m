//
//  CalendarView.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CalendarView.h"
#import "CheckViewModel.h"
#import "FDCalendar.h"
#import "CalendarCellView.h"

@interface CalendarView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) CheckViewModel *checkViewModel;

//@property(nonatomic,strong) FDCalendar *calendar;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UILabel *title;

@end

@implementation CalendarView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.checkViewModel = (CheckViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
//    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(0);
//        make.top.equalTo(0);
//        make.right.equalTo(0);
//        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:400]));
//    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
//        make.top.equalTo(weakSelf.calendar.mas_bottom).offset([self h_w:10]);
        make.top.equalTo(0);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
    }];

    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = GX_BGCOLOR;
    
//    [self addSubview:self.calendar];
    [self addSubview:self.title];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark lazyload
//-(FDCalendar *)calendar{
//    if (!_calendar) {
//        _calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
//    }
//    return _calendar;
//}

-(CheckViewModel *)checkViewModel{
    if (!_checkViewModel) {
        _checkViewModel = [[CheckViewModel alloc] init];
    }
    return _checkViewModel;
}


-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"2016年12月25日 星期五 白班";
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
        [_tableView registerClass:[CalendarCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CalendarCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.checkViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CalendarCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CalendarCellView class])] forIndexPath:indexPath];
    
    cell.calendarModel = self.checkViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.checkViewModel.cellclickSubject sendNext:row];
}

@end
