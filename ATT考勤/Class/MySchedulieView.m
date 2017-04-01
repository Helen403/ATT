//
//  MySchedulieView.m
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MySchedulieView.h"
#import "MySchedulieViewModel.h"
#import "MyCalendarView.h"
#import "MySchedulieCellView.h"



@interface MySchedulieView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) MySchedulieViewModel *mySchedulieViewModel;

@property(nonatomic,strong) MyCalendarView *myCalendarView;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) NSString *week;

@property(nonatomic,assign) NSInteger count;

@end

@implementation MySchedulieView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.mySchedulieViewModel = (MySchedulieViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.myCalendarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/7*self.count+[self h_w:33]*2));
    }];
    
    CGSize size = [LSCoreToolCenter getSizeWithText:@"2016年12月25日 星期五 白班" fontSize:14];
    CGFloat leftPadding;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        leftPadding = (SCREEN_WIDTH -size.width)*0.5;
    } else {
        leftPadding = (SCREEN_WIDTH -size.width*2)*0.5;
    }
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.top.equalTo(weakSelf.myCalendarView.mas_bottom).offset([self h_w:15]);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:15]);
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = GX_BGCOLOR;
    self.count = [self getCurrentFirstDayInMounth:0];
    
    [self addSubview:self.myCalendarView];
    [self addSubview:self.title];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_loadData{
    
}


-(void)h_bindViewModel{
    WS(weakSelf);
    self.myCalendarView.calendarBlock = ^(NSString *day){
        weakSelf.title.text = day;
    };
    
    self.myCalendarView.countBlock = ^(NSInteger count){
        weakSelf.count = count;
        [weakSelf updateConstraints];
    };
}

#pragma mark lazyload
-(MyCalendarView *)myCalendarView{
    if (!_myCalendarView) {
        _myCalendarView = [[MyCalendarView alloc] init];
    }
    return _myCalendarView;
}

-(MySchedulieViewModel *)mySchedulieViewModel{
    if (!_mySchedulieViewModel) {
        _mySchedulieViewModel = [[MySchedulieViewModel alloc] init];
    }
    return _mySchedulieViewModel;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        
        NSString *time = [NSString stringWithFormat:@"%@ %@",[LSCoreToolCenter curDateYMD],[LSCoreToolCenter currentWeek]]
        ;
        _title.text = time ;
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
        [_tableView registerClass:[MySchedulieCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MySchedulieCellView class])]];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mySchedulieViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MySchedulieCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MySchedulieCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mySchedulieModel = self.mySchedulieViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    //[self.mySchedulieViewModel.cellclickSubject sendNext:row];
}


//获得当前月份第一天星期几
-(NSInteger)getCurrentFirstDayInMounth:(NSInteger)i{
    NSInteger index=5;
    int yearTmp = [[LSCoreToolCenter curDateYear] intValue];
    
    //获取月份
    int mounth = ((int)[LSCoreToolCenter month1] + i)%12;
    NSInteger d = (i+(int)[LSCoreToolCenter month1])/12;
    if (mounth == 0&&d==1) {
        d=0;
    }
    if (mounth == 0&&d>1) {
        d = (i+(int)[LSCoreToolCenter month1])/12-1;
    }
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    //获取下个月的年月日信息,并将其转为date
    components.month = mounth;
    components.year = yearTmp+d + mounth/12;
    components.day = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [calendar dateFromComponents:components];
    //获取该月第一天星期几
    NSInteger firstDayInThisMounth = [LSCoreToolCenter firstWeekdayInThisMonth:nextDate];
    //该月的有多少天daysInThisMounth
    NSInteger daysInThisMounth = [LSCoreToolCenter totaldaysInMonth:nextDate];
    if(daysInThisMounth > 29 && (firstDayInThisMounth == 6 || firstDayInThisMounth ==5)){
        
        index = 6;
    }
    return index;
}

@end
