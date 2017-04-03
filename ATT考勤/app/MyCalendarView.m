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
#import "AttendHolidays.h"

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

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UILabel *pre;

@property(nonatomic,strong) UILabel *last;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,assign) NSInteger index;

@property(nonatomic,strong) NSIndexPath *indexPath;

@property(nonatomic,strong) NSString *current;

@property(nonatomic,strong) UILabel *today;

@property(nonatomic,strong) UILabel *week;

@end


@implementation MyCalendarView

#pragma mark system

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
    
    [self.today mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pre);
        make.right.equalTo(weakSelf.title.mas_left).offset(-[self h_w:10]);
    }];
    
    [self.week mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pre);
        make.left.equalTo(weakSelf.title.mas_right).offset([self h_w:10]);
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
    
    [self.myWeekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line2.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:30]));
    }];
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.myWeekView.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/7*(int)((int)ceil(self.arr.count/7))));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    //定义星期视图,若为周末则字体颜色为绿色
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.line1];
    [self addSubview:self.pre];
    [self addSubview:self.title];
    [self addSubview:self.last];
    [self addSubview:self.line2];
    [self addSubview:self.myWeekView];
    [self addSubview:self.today];
    [self addSubview:self.week];
    [self addSubview:self.collectionView];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)h_loadData{
    self.currentDate = [NSData data];
    self.index = 0;
    self.title.text = [LSCoreToolCenter getCurrentMonthTitle:self.index];
    self.current = self.title.text;
    self.arr = [LSCoreToolCenter getCurrentMonthInfo:self.index];
    self.week.text =[NSString stringWithFormat:@"第%ld周",(long)[LSCoreToolCenter getCurrentWeek]] ;
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
    --self.index;
    self.arr = [LSCoreToolCenter getCurrentMonthInfo:self.index];
    self.title.text = [LSCoreToolCenter getCurrentMonthTitle:self.index];
    [self.collectionView reloadData];
    [self updateConstraints];
    self.countBlock((int)ceil(self.arr.count/7));
}

-(void)lastClick{
    ++self.index;
    self.arr = [LSCoreToolCenter getCurrentMonthInfo:self.index];
    self.title.text = [LSCoreToolCenter getCurrentMonthTitle:self.index];
    [self.collectionView reloadData];
    [self updateConstraints];
    self.countBlock((int)ceil(self.arr.count/7));
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

-(UILabel *)week{
    if (!_week) {
        _week = [[UILabel alloc] init];
        _week.text = @"";
        _week.font = H14;
        _week.textColor = MAIN_PAN_2;
    }
    return _week;
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

-(UILabel *)today{
    if (!_today) {
        _today = [[UILabel alloc] init];
        _today.text = @"今天";
        _today.font = H14;
        _today.textColor = MAIN_PAN_2;
        _today.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(todayClick)];
        [_today addGestureRecognizer:setTap];
    }
    return _today;
}

-(void)todayClick{
    self.index=0;
    self.arr = [LSCoreToolCenter getCurrentMonthInfo:self.index];
    self.title.text = [LSCoreToolCenter getCurrentMonthTitle:self.index];
    [self.collectionView reloadData];
    [self updateConstraints];
    self.countBlock((int)ceil(self.arr.count/7));
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
        _collectionView.backgroundColor = [UIColor darkGrayColor];
        //注册表格
        [_collectionView registerClass:[LYWCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        
    }
    return _collectionView;
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
    cell.layer.borderColor=[UIColor darkGrayColor].CGColor;
    cell.layer.borderWidth=0.3;
    cell.dateLable.text = self.arr[indexPath.row];
    NSDate *date = [[NSDate alloc] init];
    NSInteger day = [LSCoreToolCenter day:date];
    
    //设置可点击的cell
    if(![cell.dateLable.text isEqualToString:@""]){
        
        cell.userInteractionEnabled = YES;
        cell.triangleView.hidden = NO;
        cell.title.text = @"白班";
        
    }else{
        cell.userInteractionEnabled = NO;
        cell.triangleView.hidden = YES;
        cell.title.text = @"";
    }
    
    if ([self.current isEqualToString:self.title.text]) {
        //设置今天高亮
        if (day == [cell.dateLable.text intValue]) {
            self.indexPath = indexPath;
            cell.backgroundColor = [UIColor purpleColor];
        }else{
            cell.backgroundColor = [UIColor whiteColor];
        }
    }else{
        cell.backgroundColor = [UIColor whiteColor];
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
    
    if (indexPath == self.indexPath) {
        return;
    }
    LYWCollectionViewCell *preCell =  (LYWCollectionViewCell *)[collectionView cellForItemAtIndexPath:self.indexPath];
    
    preCell.backgroundColor =[UIColor whiteColor];
    self.indexPath = indexPath;
    
    LYWCollectionViewCell *currentCell =  (LYWCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    currentCell.backgroundColor = [UIColor purpleColor];
    NSString *today = [self getToday:indexPath.row];
    NSString *day = [ NSString stringWithFormat:@"%@%@日 %@",self.title.text,currentCell.dateLable.text,today];
    self.calendarBlock(day);
}



-(NSString *)getToday:(NSInteger )i{
    NSString *str = @"";
    switch (i%7) {
        case 1:
            str = @"星期一";
            break;
        case 2:
            str = @"星期二";
            break;
        case 3:
            str = @"星期三";
            break;
        case 4:
            str = @"星期四";
            break;
        case 5:
            str = @"星期五";
            break;
        case 6:
            str = @"星期六";
            break;
        case 0:
            str = @"星期日";
            break;
            
    }
    return str;
}




@end
