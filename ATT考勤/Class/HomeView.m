//
//  HomeView.m
//  ATT考勤
//
//  Created by Helen on 16/12/21.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HomeView.h"
#import "HomeViewModel.h"

@interface HomeView()

@property(nonatomic,strong) HomeViewModel *homeViewModel;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIImageView *setImg;

@property(nonatomic,strong) UIImageView *headImg;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *department;

@property(nonatomic,strong) UILabel *status;

//上一个时间段图片
@property(nonatomic,strong) UIImageView *preImg;

@property(nonatomic,strong) UILabel *preText;

//下一个时间段图片
@property(nonatomic,strong) UIImageView *lastImg;

@property(nonatomic,strong) UILabel *lastText;

//包裹下面的view
@property(nonatomic,strong) UIView *view;

@property(nonatomic,strong) UIImageView *punch;

@property(nonatomic,strong) UILabel *week;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *year;

@property(nonatomic,strong) UIImageView *netStatusImg;

@property(nonatomic,strong) UILabel *netStatusText;

//时间
@property(nonatomic,strong) NSTimer *timeNow;

@property(nonatomic,strong) NSDateFormatter *formatter;

@property(nonatomic,assign) CGFloat width;

@property(nonatomic,strong) UIScrollView *scrollView;



@end

@implementation HomeView

-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.homeViewModel = (HomeViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    
    CGFloat paddingleft = SCREEN_WIDTH*0.1;
    
    CGFloat length = SCREEN_WIDTH*0.7;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo([self h_w:30]);
    }];
    
    [self.setImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
        make.top.equalTo([self h_w:26]);
        make.size.equalTo(CGSizeMake([self h_w:25], [self h_w:25]));
    }];
    
    
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:10]);
        make.left.equalTo([self h_w:10]);
        make.size.equalTo(CGSizeMake([self h_w:80], [self h_w:80]));
    }];
    
    [self.department mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImg.mas_right).offset([self h_w:10]);
        make.bottom.equalTo(weakSelf.headImg.mas_bottom);
    }];
    
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImg.mas_right).offset([self h_w:10]);
        make.bottom.equalTo(weakSelf.department.mas_top);
    }];
    
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.headImg.mas_bottom);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    
    [self.preImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(paddingleft);
        make.top.equalTo(weakSelf.headImg.mas_bottom).offset([self h_w:15]);
        make.size.equalTo(CGSizeMake([self h_w:30], [self h_w:23]));
    }];
    
    [self.preText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.preImg.mas_right).offset([self h_w:10]);
        make.centerY.equalTo(weakSelf.preImg);
    }];
    
    [self.lastText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-paddingleft);
        make.centerY.equalTo(weakSelf.preImg);
    }];
    
    
    [self.lastImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.preImg);
        make.right.equalTo(weakSelf.lastText.mas_left).offset(-[self h_w:10]);
        make.size.equalTo(CGSizeMake([self h_w:30], [self h_w:23]));
    }];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lastImg.mas_bottom).offset([self h_w:15]);
        make.left.right.bottom.equalTo(weakSelf);
        
    }];

    [self.punch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset([self h_w:15]);
        make.size.equalTo(CGSizeMake(length, length+[self h_w:15]));
        make.centerX.equalTo(weakSelf.view);
    }];
    
    [self.week mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.punch.mas_top).offset([self h_w:40]);
        make.centerX.equalTo(weakSelf.punch);
    }];
    
   CGSize size = [LSCoreToolCenter getSizeWithText:@"08:49:07" fontSize:42];
    
    CGFloat leftPadding = (SCREEN_WIDTH -size.width*2)*0.5;
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.week.mas_bottom).offset([self h_w:30]);
        make.left.equalTo(leftPadding);
    }];
    
    
    [self.year mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.time.mas_bottom).offset([self h_w:20]);
        make.centerX.equalTo(weakSelf.punch);
    }];
    
    [self.netStatusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.time.mas_left);
        make.top.equalTo(weakSelf.punch.mas_bottom).offset([self h_w:20]);
        make.size.equalTo(CGSizeMake([self h_w:35], [self h_w:35]));
    }];
    
    [self.netStatusText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.punch.mas_bottom).offset([self h_w:20]);
        make.left.equalTo(weakSelf.netStatusImg.mas_right).offset([self h_w:10]);
        make.centerY.equalTo(weakSelf.netStatusImg);
    }];
    
    
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.netStatusText.mas_bottom).offset(20);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    [self addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.title];
    [self.scrollView addSubview:self.setImg];
    [self.scrollView addSubview:self.headImg];
    [self.scrollView addSubview:self.name];
    [self.scrollView addSubview:self.department];
    [self.scrollView addSubview:self.status];
    [self.scrollView addSubview:self.preImg];
    [self.scrollView addSubview:self.preText];
    [self.scrollView addSubview:self.lastImg];
    [self.scrollView addSubview:self.lastText];
    [self.scrollView addSubview:self.view];
    [self.scrollView addSubview:self.punch];
    [self.scrollView addSubview:self.week];
    [self.scrollView addSubview:self.time];
    [self.scrollView addSubview:self.year];
    [self.scrollView addSubview:self.netStatusImg];
    [self.scrollView addSubview:self.netStatusText];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    //    //判断是否已经打卡
    //    if (self.punch.userInteractionEnabled) {
    //        //开启定时器
    //        [self.timeNow setFireDate:[NSDate distantPast]];
    //    }
    
    
    //设置时间
    [self setTime];
     [self addDynamic:self];
}


-(void)setTime{
    //设置星期几
    [self.week setText: [LSCoreToolCenter currentWeek]];
    //设置年月日
    [self.year setText: [LSCoreToolCenter currentYear]];
    
    //设置定时
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    self.formatter = formatter;
    self.timeNow = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
}

//时间变化
- (void)timeRun{
    
    NSString *timetmp = [self.formatter stringFromDate:[NSDate date]];
    
    [self.time setText:timetmp];//时间在变化的语句
    
}

////点击打卡
-(void)onClickImage{
    
    [self toast:@"打卡成功"];
    self.punch.userInteractionEnabled = NO;
    //    //切换图片
    //    [self.imageView setImage:[UIImage imageNamed:@"homepage_Clock_button_blue"]];
    //    //关闭定时器
    [self.timeNow setFireDate:[NSDate distantFuture]];
    //
    //    //网络请求打卡
    //    [self AttendCard];
     NSString *timetmp = [self.formatter stringFromDate:[NSDate date]];
    self.preText.text = timetmp;
    //
}

#pragma mark lazyload
-(HomeViewModel *)homeViewModel{
    if (!_homeViewModel) {
        _homeViewModel = [[HomeViewModel alloc] init];
    }
    return _homeViewModel;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"韦达公司";
        _title.textColor = black_color;
        _title.font = H18;
    }
    
    return _title;
}

-(UIImageView *)setImg{
    if (!_setImg) {
        _setImg = [[UIImageView alloc] init];
        _setImg.image = ImageNamed(@"homepage_gray");
        _setImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(set)];
        [_setImg addGestureRecognizer:setTap];
    }
    return _setImg;
}

-(void)set{
    [self.homeViewModel.setClickSubject sendNext:nil];
}


-(UIImageView *)headImg{
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        _headImg.image = ImageNamed(@"homepage_head_portrait_base");
        _headImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HeadClick)];
        [_headImg addGestureRecognizer:setTap];
        
    }
    return _headImg;
}


-(void)HeadClick{
    [self.homeViewModel.headclickSubject sendNext:nil];
}


-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"吴 涛";
        _name.font = H14;
        
    }
    return _name;
}

-(UILabel *)department{
    if (!_department) {
        _department = [[UILabel alloc] init];
        _department.text = @"产品部 工程师";
        
    }
    return _department;
}

-(UILabel *)status{
    if (!_status) {
        _status = [[UILabel alloc] init];
        _status.text = @"状态:上班";
        _status.font = H22;
    }
    
    return _status;
}

-(UIImageView *)preImg{
    
    if (!_preImg) {
        _preImg = [[UIImageView alloc] init];
        _preImg.image = ImageNamed(@"homepage_work_orange");
    }
    return _preImg;
}

-(UILabel *)preText{
    if (!_preText) {
        _preText = [[UILabel alloc] init];
        _preText.text = @"08:29:55";
    }
    return _preText;
}

-(UIImageView *)lastImg{
    if (!_lastImg) {
        _lastImg = [[UIImageView alloc] init];
        _lastImg.image = ImageNamed(@"homepage_rest_orange");
    }
    return _lastImg;
}

-(UILabel *)lastText{
    if (!_lastText) {
        _lastText = [[UILabel alloc] init];
        _lastText.text = @"14:50:55";
    }
    return _lastText;
}
-(UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] init];
        _view.backgroundColor = RGBCOLOR(240, 240, 241);
    }
    return _view;
}

-(UIImageView *)punch{
    if (!_punch) {
        _punch = [[UIImageView alloc] init];
        _punch.image = ImageNamed(@"homepage_Clock_button");
        _punch.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
        [_punch addGestureRecognizer:setTap];
    }
    return _punch;
    
}

-(UILabel *)week{
    if (!_week) {
        _week = [[UILabel alloc] init];
        _week.text = @"星期五";
        _week.font = H26;
        _week.textColor = RGBCOLOR(117, 117, 117);
    }
    return _week;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"14:50:55";
        _time.font = HB42;
        _time.textColor = RGBCOLOR(80, 80, 80);

    }
    return _time;
}
-(UILabel *)year{
    if (!_year) {
        _year = [[UILabel alloc] init];
        _year.text = @"2016年11月11日";
        _year.font = H18;
        _year.textColor = RGBCOLOR(179, 180, 182);
    }
    return _year;
}

-(UIImageView *)netStatusImg{
    if (!_netStatusImg) {
        _netStatusImg = [[UIImageView alloc] init];
        _netStatusImg.image = ImageNamed(@"wifi");
    }
    return _netStatusImg;
}

-(UILabel *)netStatusText{
    if (!_netStatusText) {
        _netStatusText = [[UILabel alloc] init];
        _netStatusText.text = @"当前连接WIFI:vada";
        _netStatusText.font = H18;
        _netStatusText.textColor = RGBCOLOR(131, 131, 131);
    }
    return _netStatusText;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
       
        
    }
    return _scrollView;
}



@end
