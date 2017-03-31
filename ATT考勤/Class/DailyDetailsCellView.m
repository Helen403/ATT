//
//  DailyDetailsCellView.m
//  ATT考勤
//
//  Created by Helen on 17/3/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "DailyDetailsCellView.h"
#import "LeaveEarlyController.h"
#import "LateController.h"
#import "DrainPunchController.h"


@interface DailyDetailsCellView()

@property(nonatomic,strong) UILabel *start;

@property(nonatomic,strong) UILabel *startState;

@property(nonatomic,strong) UIButton *startButton;

@property(nonatomic,strong) UIView *line;

@end


@implementation DailyDetailsCellView

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    [self.start mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:20]);
         make.centerY.equalTo(weakSelf);
    }];

    [self.startState mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(weakSelf);
           make.left.equalTo(SCREEN_WIDTH/2);
    }];
 
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
         make.size.equalTo(CGSizeMake([self h_w:70], [self h_w:30]));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:1]);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];

    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.start];
    [self addSubview:self.startState];
    [self addSubview:self.startButton];
    [self addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)h_bindViewModel{
}

#pragma mark dataload
-(void)setCardDetaillist:(CardDetaillist *)cardDetaillist{
    if (!cardDetaillist) {
        return;
    }
    _cardDetaillist = cardDetaillist;
    
    self.start.text = cardDetaillist.cardRealDatetime;
    if ([cardDetaillist.cardStatus isEqualToString:@"0"]) {
        self.startState.text = @"正常";
        self.startButton.hidden = YES;

    }
    if ([cardDetaillist.cardStatus isEqualToString:@"1"]) {
        self.startState.text = @"早退";
        [self.startButton setTitle:@"消早退" forState:UIControlStateNormal];
        self.startButton.hidden = NO;
    }
    if ([cardDetaillist.cardStatus isEqualToString:@"2"]) {
        self.startState.text = @"迟到";
        [self.startButton setTitle:@"消迟到" forState:UIControlStateNormal];
        self.startButton.hidden = NO;
    }
    if ([cardDetaillist.cardStatus isEqualToString:@"3"]) {
        self.startState.text = @"漏打卡";
        [self.startButton setTitle:@"补打卡" forState:UIControlStateNormal];
        self.startButton.hidden = NO;
    }
}
#pragma mark lazyload
-(UILabel *)start{
    if (!_start) {
        _start = [[UILabel alloc] init];
        _start.text = @"";
        _start.font = H14;
        _start.textColor = MAIN_PAN_2;
    }
    return _start;
}


-(UILabel *)startState{
    if (!_startState) {
        _startState = [[UILabel alloc] init];
        _startState.text = @"";
        _startState.font = H14;
        _startState.textColor = MAIN_PAN_2;
    }
    return _startState;
}


-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
}

-(UIButton *)startButton{
    if (!_startButton) {
        _startButton = [[UIButton alloc] init];
        
        _startButton.titleLabel.font = H14;
        [_startButton addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
        [_startButton.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [_startButton.layer setCornerRadius:10];
        [_startButton.layer setBorderWidth:2];//设置边界的宽度
        [_startButton setBackgroundColor:MAIN_ORANGER];
        [_startButton.layer setBorderColor:MAIN_ORANGER.CGColor];
        _startButton.hidden = YES;
    }
    return _startButton;
}

-(void)startClick:(UIButton *)button{
    //消早退
    if ([self.cardDetaillist.cardStatus isEqualToString:@"1"]) {
      
        LeaveEarlyController *leaveEarly = [[LeaveEarlyController alloc] init];
        
        leaveEarly.startDate =[NSString stringWithFormat:@"%@ %@",self.busDate,[self.cardDetaillist.cardRealDatetime substringFromIndex:5]];
        leaveEarly.endDate =[NSString stringWithFormat:@"%@ %@:00",self.busDate,self.cardDetaillist.cardNormalDatetime]  ;
        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
        [nav pushViewController:leaveEarly animated:NO];

    }
    //消迟到
    if ([self.cardDetaillist.cardStatus isEqualToString:@"2"]) {
      

        LateController *late = [[LateController alloc] init];
        late.startDate =[NSString stringWithFormat:@"%@ %@",self.busDate,[self.cardDetaillist.cardRealDatetime substringFromIndex:5]];
        late.endDate =[NSString stringWithFormat:@"%@ %@:00",self.busDate,self.cardDetaillist.cardNormalDatetime]  ;
        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
        [nav pushViewController:late animated:NO];
       
    }
    //漏打卡
    if ([self.cardDetaillist.cardStatus isEqualToString:@"3"]) {
        
        DrainPunchController *drainPunch = [[DrainPunchController alloc] init];
        drainPunch.startDate =[NSString stringWithFormat:@"%@ %@",self.busDate,[self.cardDetaillist.cardRealDatetime substringFromIndex:5]];
        drainPunch.endDate =[NSString stringWithFormat:@"%@ %@:00",self.busDate,self.cardDetaillist.cardNormalDatetime]  ;
        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
        [nav pushViewController:drainPunch animated:NO];
    }
}




@end
