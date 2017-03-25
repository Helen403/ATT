//
//  MyDatePickerView.m
//  ATT考勤
//
//  Created by Helen on 17/3/24.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyDatePickerView.h"
#import "NSDate+Extension.h"
#import "UIView+Extension.h"

#define kPickerSize self.datePicker.frame.size
#define RGBA(r, g, b, a) ([UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a])
#define RGB(r, g, b) RGBA(r,g,b,1)


#define MAXYEAR 2050
#define MINYEAR 1970

typedef void(^doneBlock)(NSDate *,NSDate *);
typedef enum{
    DateStyleShowYearMonthDayHourMinute  = 0,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowYearMonthDay,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute
    
}XHDateStyle;


@interface MyDatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate> {
    //日期存储数组
    NSMutableArray *_yearArray;
    NSMutableArray *_monthArray;
    NSMutableArray *_dayArray;
    NSMutableArray *_hourArray;
    NSMutableArray *_minuteArray;
    NSString *_dateFormatter;
    //记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    NSInteger hourIndex;
    NSInteger minuteIndex;
    
    NSInteger preRow;
    
    NSDate *_startDate;
   
    NSArray *_proTimeList;
    NSArray *_proTitleList;
}


@property (strong, nonatomic)  UIView *buttomView;

@property (strong, nonatomic)  UILabel *showYearView;
@property (strong, nonatomic)  UIButton *doneBtn;
@property (strong, nonatomic)  NSLayoutConstraint *bottomConstraint;

@property (nonatomic,strong) UIPickerView *datePicker;
@property (nonatomic, retain) NSDate *scrollToDate;//滚到指定日期
@property (nonatomic,strong) doneBlock doneBlock;

@end

@implementation MyDatePickerView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(weakSelf);
          make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:10]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:170]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    //self.datePicker.frame
    _proTimeList = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    _proTitleList = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    [self addSubview:self.buttomView];
    [self addSubview:self.datePicker];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_loadData{
   
    self.backgroundColor = RGBA(0, 0, 0, 0);
    //点击背景是否影藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
   _dateFormatter = @"yyyy-MM-dd HH:mm";
    
    self.bottomConstraint.constant = -self.height;
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if( [touch.view isDescendantOfView:self.buttomView]) {
        return NO;
    }
    return YES;
}


#pragma mark lazyload
-(UIView *)buttomView{
    if (!_buttomView) {
        _buttomView = [[UIView alloc] init];
        _buttomView.layer.cornerRadius = 10;
        _buttomView.layer.masksToBounds = YES;
    }
    return _buttomView;
}

-(UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [[UIButton alloc] init];
        
    }
    return _doneBtn;
}


-(UIPickerView *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIPickerView alloc] init];
        _datePicker.showsSelectionIndicator = YES;
        _datePicker.delegate = self;
        _datePicker.dataSource = self;
    }
    return _datePicker;
}

#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [_proTitleList count];
    }
    
    return [_proTimeList count];
}


#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 1) {
        return 40;
    }
    return 180;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        NSString  *_proNameStr = [_proTitleList objectAtIndex:row];
        NSLog(@"nameStr=%@",_proNameStr);
    } else {
        NSString  *_proTimeStr = [_proTimeList objectAtIndex:row];
        NSLog(@"_proTimeStr=%@",_proTimeStr);
    }
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [_proTitleList objectAtIndex:row];
    } else {
        return [_proTimeList objectAtIndex:row];
        
    }
}

-(void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.bottomConstraint.constant = 10;
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self layoutIfNeeded];
    }];
}
-(void)dismiss {
    [UIView animateWithDuration:.3 animations:^{
        self.bottomConstraint.constant = -self.height;
        self.backgroundColor = RGBA(0, 0, 0, 0);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}

@end
