//
//  MyCalendarView.m
//  ATT考勤
//
//  Created by Helen on 17/3/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyCalendarView.h"
#import "LYWCollectionViewCell.h"
#import "MyWeekView.h"

static NSString *cellID = @"cellID";

@interface MyCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSData *currentDate;

//表格视图
@property(nonatomic,strong) UICollectionView *collectionView;
//当月第一天星期几
@property(nonatomic,assign) NSInteger firstDayInMounthInWeekly;

@property(nonatomic,strong) NSMutableArray *firstMounth;

@property(nonatomic,strong) NSMutableArray *arr;

@property(nonatomic,strong) MyWeekView *myWeekView;

@property(nonatomic,strong) UILabel *pre;

@property(nonatomic,strong) UILabel *last;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIView *line;

@property(nonatomic,assign) NSInteger index;

@end


@implementation MyCalendarView

#pragma mark system

-(void)updateConstraints{
    
    WS(weakSelf);
    
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
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pre.mas_bottom).offset(10);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.myWeekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:30]));
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.myWeekView.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/7*6));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    self.currentDate = [NSData data];
    //定义星期视图,若为周末则字体颜色为绿色
    
    
    [self addSubview:self.pre];
    [self addSubview:self.title];
    [self addSubview:self.last];
    [self addSubview:self.line];
    [self addSubview:self.myWeekView];
    [self addSubview:self.collectionView];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)h_loadData{
    
    self.index = 0;
    self.title.text = [self getCurrentMonthTitle:self.index];
    self.arr = [self getCurrentMonthInfo:self.index];
}

#pragma mark lazyload

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
    self.index --;
    self.arr = [self getCurrentMonthInfo:self.index];
    self.title.text = [self getCurrentMonthTitle:self.index];
    [self.collectionView reloadData];
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

-(void)lastClick{
    self.index ++;
    self.arr = [self getCurrentMonthInfo:self.index];
    self.title.text = [self getCurrentMonthTitle:self.index];
    [self.collectionView reloadData];
}


-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}


-(MyWeekView *)myWeekView{
    if (!_myWeekView) {
        _myWeekView = [[MyWeekView alloc] init];
    }
    return _myWeekView;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self h_w:180]) collectionViewLayout:layout];
        //设置collectionView及自动布局,代理方法尤为重要
        
        //头部始终在顶端
        layout.sectionHeadersPinToVisibleBounds = YES;
        //头部视图高度
        
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册表格
        [_collectionView registerClass:[LYWCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

// i为0就是当月  i为－1就是上个月 i为1 就是下个月
-(NSMutableArray *)getCurrentMonthInfo:(NSInteger)i{
    NSMutableArray *arrTmp = [NSMutableArray array];
    int yearTmp = [[LSCoreToolCenter curDateYear] intValue];
    
    //获取月份
    int mounth = ((int)[self month1] + i)%12;
    NSInteger d = (i+(int)[self month1])/12;
    if (mounth==0&&d==1) {
        d=0;
    }
    if (mounth==0&&d>1) {
        d = (i+(int)[self month1])/12-1;
    }
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    //获取下个月的年月日信息,并将其转为date
    components.month = mounth;
    components.year = yearTmp+d + mounth/12;
    components.day = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [calendar dateFromComponents:components];
    //获取该月第一天星期几
    NSInteger firstDayInThisMounth = [self firstWeekdayInThisMonth:nextDate];
    //该月的有多少天daysInThisMounth
    NSInteger daysInThisMounth = [self totaldaysInMonth:nextDate];
    NSString *string = [[NSString alloc]init];
    for (int j = 0; j < (daysInThisMounth > 29 && (firstDayInThisMounth == 6 || firstDayInThisMounth ==5) ? 42 : 35) ; j++) {
        if (j < firstDayInThisMounth || j > daysInThisMounth + firstDayInThisMounth - 1) {
            string = @"";
            [arrTmp addObject:string];
        }else{
            string = [NSString stringWithFormat:@"%ld",j - firstDayInThisMounth + 1];
            [arrTmp addObject:string];
        }
    }
    
    return arrTmp;
}


-(NSString *)getCurrentMonthTitle:(NSInteger)i{
    int yearTmp = [[LSCoreToolCenter curDateYear] intValue];
    
    //获取月份
    int mounth = ((int)[self month1] + i)%12;
    NSInteger d = (i+(int)[self month1])/12;
    if (mounth==0&&d==1) {
        d=0;
    }
    if (mounth==0&&d>1) {
        d = (i+(int)[self month1])/12-1;
    }
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    //获取下个月的年月日信息,并将其转为date
    components.month = mounth;
    components.year = yearTmp+d + mounth/12;
    components.day = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [calendar dateFromComponents:components];
    NSDateFormatter *dateFormattor = [[NSDateFormatter alloc] init];
    [dateFormattor setDateFormat:@"MM"];
    
    NSString *str = [dateFormattor stringFromDate:nextDate];
    return [NSString stringWithFormat:@"%ld年%@月",yearTmp+d,str];;
}

//这两个不用说,返回cell个数及section个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


//这里是自定义cell,非常简单的自定义
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LYWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.dateLable.text = self.arr[indexPath.row];
    NSDate *date = [[NSDate alloc] init];
    NSInteger day = [self day:date];
    if (day == [cell.dateLable.text intValue]) {
        cell.selected = YES;
    }
    //设置单击后的颜色
    if(![cell.dateLable.text isEqualToString:@""]){
        UIView *blackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        blackgroundView.backgroundColor = [UIColor yellowColor];
        cell.selectedBackgroundView = blackgroundView;
        cell.userInteractionEnabled = YES;
    }else{
        cell.userInteractionEnabled = NO;
    }
    return cell;
}

//cell大小及间距
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/7, SCREEN_WIDTH/7);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LYWCollectionViewCell *cell = [self collectionView:_collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@%@日",self.title.text,cell.dateLable.text);
    
}


/**
 *实现部分
 */
#pragma mark -- 获取日
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.day;
}

#pragma mark -- 获取月
- (NSInteger)month:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.month;
}

- (NSInteger)month1{
    NSDateComponents * conponent = [[NSCalendar currentCalendar] components: NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
    
    return [conponent month];
}

#pragma mark -- 获取年
- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.year;
}

#pragma mark -- 获得当前月份第一天星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置每周的第一天从周几开始,默认为1,从周日开始
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    //若设置从周日开始算起则需要减一,若从周一开始算起则不需要减
    return firstWeekday - 1;
}
#pragma mark -- 获取当前月共有多少天

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}


@end
