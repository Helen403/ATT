//
//  HomeView.m
//  ATT考勤
//
//  Created by Helen on 16/12/21.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HomeView.h"
#import "HomeViewModel.h"

#import "UserModel.h"
#import "EmpModel.h"
#import "Dept.h"
#import "AttendWorkShift.h"
#import "AttendWorkShiftDetail.h"
#import "BMKLocationService.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "YYAudioTool.h"
#import "AttendCardRecord.h"


@interface HomeView()<BMKLocationServiceDelegate>

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

@property(nonatomic,strong) UIImageView *bg;


@property(nonatomic,strong) NSString *locLongitude;

@property(nonatomic,strong) NSString *locLatitude;

@property(nonatomic,strong) NSString *locAddress;

@property(nonatomic,strong) BMKLocationService *locService;

@property(nonatomic,strong) NSString *clockMode;


@property(nonatomic,assign) NSInteger cardPhase;

@property(nonatomic,assign) NSInteger timePoint;

@property(nonatomic,assign) NSInteger retCode;




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
        make.top.equalTo(weakSelf.view.mas_top).offset([self h_w:25]);
        make.size.equalTo(CGSizeMake(length, length+[self h_w:15]));
        make.centerX.equalTo(weakSelf.view);
    }];
    
    [self.week mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.punch.mas_top).offset([self h_w:40]);
        make.centerX.equalTo(weakSelf.punch);
    }];
    
    CGSize size = [LSCoreToolCenter getSizeWithText:@"08:49:07" fontSize:42];
    CGFloat leftPadding;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        leftPadding = (SCREEN_WIDTH -size.width)*0.5;
    } else {
        leftPadding = (SCREEN_WIDTH -size.width*2)*0.5;
    }
    
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
        make.top.equalTo(weakSelf.punch.mas_bottom).offset([self h_w:70]);
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
    
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self.view addSubview:self.bg];
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


-(void)h_loadData{
    NSString *companyNickName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyNickName"];
    self.title.text = companyNickName;
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.homeViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.homeViewModel.userCode = user.userCode;
    NSMutableArray *arr = [LSCoreToolCenter currentYearArr];
    self.homeViewModel.curYear = arr[0];
    self.homeViewModel.curMonth = arr[1];
    self.homeViewModel.curDay = arr[2];
    
    [self.homeViewModel.sendclickCommand execute:nil];
    //设置时间
    [self setTime];
    //检查网络
    [self isNetWorking];
    //定位
    [self setLocation];
    
    self.cardPhase = 0; //打卡阶段
    self.timePoint = 1; //打卡时间点 A=1,B=2,C=3,D=4,E=5,F=6,G=7,H=8
    self.retCode = -1;  //打卡返回码
}

-(void)isNetWorking{
    
    //开启网络指示器，开始监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                self.clockMode = @"1";
                self.netStatusText.text = @"当前无网络";
                break;
            }
                
            case AFNetworkReachabilityStatusNotReachable:{
                
                //                NSLog(@"无网络");
                self.clockMode = @"1";
                self.netStatusText.text = @"当前无网络";
                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                self.clockMode = @"WIFI";
                //                NSLog(@"WiFi网络");
                [self setWIFINAME];
                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                self.clockMode = @"WWAN";
                //                NSLog(@"无线网络");
                [self setWWAN];
                break;
                
            }
        }
    }];
    
}

-(void)setWWAN{
    self.netStatusText.text = @"当前连接GPS";
}

-(void)setWIFINAME{
    id info = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSString *str = info[@"SSID"];
        //        NSString *str2 = info[@"BSSID"];
        //        NSString *str3 = [[ NSString alloc] initWithData:info[@"SSIDDATA"] encoding:NSUTF8StringEncoding];
        
        self.netStatusText.text = [NSString stringWithFormat:@"当前连接WIFI:%@",str];
    }
}

-(void)setLocation{
    
    //启动LocationService
    [self.locService startUserLocationService];
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D coord = [userLocation coordinate];
    NSLog(@"经度:%f,纬度:%f",coord.latitude,coord.longitude);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            if (placemark != nil) {
                //                NSString *city = placemark.locality;
                //                //                NSLog(@"%@",city);
                //                NSString *city1 = placemark.name;
                //                //                NSLog(@"%@",city1);
                //                self.locAddress = [NSString stringWithFormat:@"%@%@",city,city1];
                NSDictionary *city2 = placemark.addressDictionary;
                //                NSLog(@"%@",city2);
                NSArray *dict = city2[@"FormattedAddressLines"];
                NSString *str=  [dict objectAtIndex:0];
                //                NSLog(@"%@",str);
                //                NSString *city3 = placemark.region;
                //                NSLog(@"%@",city3);
                //找到了当前位置城市后就关闭服务
                
                
                
                [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"locAddress"];
                
                [self.locService stopUserLocationService];
                
            }
        }
    }];
    
    
}


//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    
    //    ShowMessage(@"定位成功");
    NSString *currentLatitude = [[NSString alloc]
                                 initWithFormat:@"%f",
                                 userLocation.location.coordinate.latitude];
    
    NSString *currentLongitude = [[NSString alloc]
                                  initWithFormat:@"%f",
                                  userLocation.location.coordinate.longitude];
    
    self.locLongitude = currentLongitude;
    
    self.locLatitude = currentLatitude;
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            if (placemark != nil) {
                //                NSString *city = placemark.locality;
                //                //                NSLog(@"%@",city);
                //                NSString *city1 = placemark.name;
                //                //                NSLog(@"%@",city1);
                //                self.locAddress = [NSString stringWithFormat:@"%@%@",city,city1];
                NSDictionary *city2 = placemark.addressDictionary;
                //                NSLog(@"%@",city2);
                NSArray *dict = city2[@"FormattedAddressLines"];
                NSString *str=  [dict objectAtIndex:0];
                //                NSLog(@"%@",str);
                //                NSString *city3 = placemark.region;
                //                NSLog(@"%@",city3);
                //找到了当前位置城市后就关闭服务
                
                
                
                [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"locAddress"];
                
                [self.locService stopUserLocationService];
                
            }
        }
    }];
    
}


-(void)addresses:(NSString *)str{
    self.locAddress = str;
}

-(void)h_bindViewModel{
    
    //设置时间
    
    [self addDynamic:self];
    
    
    [[self.homeViewModel.resultSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *x) {
        
        [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
    }];
    
    [[self.homeViewModel.attendRecordSuccessSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self attendCardSuccess];
            
        });
        
    }];
    
    [[self.homeViewModel.attendRecordSuccessSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.punch.userInteractionEnabled = YES;
            //设置时间
            //            [self setTime];
            
        });
        
    }];
    
    [[self.homeViewModel.attendRecordSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        [self performSelectorOnMainThread:@selector(attendRecord) withObject:nil waitUntilDone:YES];
        
    }];
    
}
-(void)attendRecord{
    
    if (self.homeViewModel.arrAttendRecord.count == 1) {
        AttendCardRecord *attendCardRecord1 = self.homeViewModel.arrAttendRecord[0];
        //已经打过卡
        if ([attendCardRecord1.cardStatus isEqualToString:@"0"]) {
            self.status.text = @"正常";
            //            self.preImg =
        }
        //早退
        if ([attendCardRecord1.cardStatus isEqualToString:@"1"]){
            self.status.text = @"早退";
        }
        //迟到
        if ([attendCardRecord1.cardStatus isEqualToString:@"2"]){
            self.status.text = @"迟到";
        }
    }
    
    if (self.homeViewModel.arrAttendRecord.count == 2) {
        AttendCardRecord *attendCardRecord1 = self.homeViewModel.arrAttendRecord[0];
        AttendCardRecord *attendCardRecord2 = self.homeViewModel.arrAttendRecord[0];
    }
    
}


//打卡后更新界面
-(void)attendCardSuccess{
    
    // A=1,B=2,C=3,D=4,E=5,F=6,G=7,H=8
    if(self.timePoint==1||self.timePoint==3||self.timePoint==5||self.timePoint==7){
        self.preText.text = [LSCoreToolCenter currentDateHMS];
        if ([LSCoreToolCenter isDayOrNight:self.preText.text]) {
            self.preImg.image = ImageNamed(@"homepage_rest_orange");
        }else{
            self.preImg.image = ImageNamed(@"homepage_work_orange");
        }
    }else{
        self.lastText.text= [LSCoreToolCenter currentDateHMS];
        if ([LSCoreToolCenter isDayOrNight:self.lastText.text]) {
            self.lastImg.image = ImageNamed(@"homepage_rest_green");
        }else{
            self.lastImg.image = ImageNamed(@"homepage_work_green");
        }
    }
    //打卡状态
    if(self.retCode==0){
        
        self.status.text =@"状态:正常";
    }
    if(self.retCode==1){
        
        self.status.text =@"状态:早退";
    }
    if(self.retCode==2){
        self.status.text =@"状态:迟到";
    }
    
}


-(void)mainThread{
    EmpModel *empModel =  self.homeViewModel.empModel;
    Dept *dept = self.homeViewModel.dept;

    self.name.text = empModel.empName;
    self.department.text = [NSString stringWithFormat:@"%@ %@",dept.deptNickName,empModel.position];
    
    /*********************************************/
    //    Dept *deptTmp =  self.homeViewModel.dept;
    AttendWorkShift *attendWorkShift = self.homeViewModel.attendWorkShift;
    NSString *count =  attendWorkShift.daySignCount;
    
    NSString *curDate = [LSCoreToolCenter currentYearType];
    NSString *curDatetime = [LSCoreToolCenter curDate];
    if ([@"2" isEqualToString:count]) {
        AttendWorkShiftDetail *detail1 = self.homeViewModel.arr[0];
        self.preText.text = [NSString stringWithFormat:@"%@:00",detail1.workStartDatetime];
        self.lastText.text = [NSString stringWithFormat:@"%@:00",detail1.workEndDatetime];
        self.cardPhase=0;
    }
    
    /**************************************************/
    if ([@"4" isEqualToString:count]) {
        AttendWorkShiftDetail *detail1 = self.homeViewModel.arr[0];
        AttendWorkShiftDetail *detail2 = self.homeViewModel.arr[1];
        
        NSString *strCdatetime=[NSString stringWithFormat:@"%@ %@:00",curDate,detail2.workStartDatetime]; //取的第2次上班时间
        
        NSString *strCbeforedatetime = [LSCoreToolCenter getDateAddMinuts:strCdatetime time:-1*offSetCardArea];
        long diffC = [LSCoreToolCenter getDateDiff:curDatetime end:strCbeforedatetime];
        if(diffC>0){
            //显示第1阶段打卡时间
            self.cardPhase=0;
            self.preText.text = [NSString stringWithFormat:@"%@:00",detail1.workStartDatetime];
            self.lastText.text = [NSString stringWithFormat:@"%@:00",detail1.workEndDatetime];
        }else{
            //显示第2阶段打卡时间
            self.cardPhase=1;
            self.preText.text = [NSString stringWithFormat:@"%@:00",detail2.workStartDatetime];
            self.lastText.text = [NSString stringWithFormat:@"%@:00",detail2.workEndDatetime];
        }
        
    }
    /**************************************************/
    if ([@"6" isEqualToString:count]) {
        AttendWorkShiftDetail *detail1 = self.homeViewModel.arr[0];
        AttendWorkShiftDetail *detail2 = self.homeViewModel.arr[1];
        AttendWorkShiftDetail *detail3 = self.homeViewModel.arr[2];

        NSString *strCdatetime=[NSString stringWithFormat:@"%@ %@:00",curDate,detail2.workStartDatetime]; //取的第2次上班时间
        NSString *strCbeforedatetime = [LSCoreToolCenter getDateAddMinuts:strCdatetime time:-1*offSetCardArea];
        long diffC = [LSCoreToolCenter getDateDiff:curDatetime end:strCbeforedatetime];
				    
        
        NSString *strEdatetime=[NSString stringWithFormat:@"%@ %@:00",curDate,detail3.workStartDatetime]; //取的第3次上班时间
        NSString *strEbeforedatetime = [LSCoreToolCenter getDateAddMinuts:strEdatetime time:-1*offSetCardArea];
        long diffE = [LSCoreToolCenter getDateDiff:curDatetime end:strEbeforedatetime];
        
        long diffCE = [LSCoreToolCenter getDateDiff:strCbeforedatetime end:strEbeforedatetime]; //计算C,E点时间差
        
        if(diffC>0){
            //显示第1阶段打卡时间
            self.cardPhase=0;
            self.preText.text = [NSString stringWithFormat:@"%@:00",detail1.workStartDatetime];
            self.lastText.text = [NSString stringWithFormat:@"%@:00",detail1.workEndDatetime];
        }else{
            if(diffCE>=diffE&&diffE>0){
                //显示第2阶段打卡时间
                self.cardPhase=1;
                self.preText.text = [NSString stringWithFormat:@"%@:00",detail2.workStartDatetime];
                self.lastText.text = [NSString stringWithFormat:@"%@:00",detail2.workEndDatetime];
            }else{
                //显示第3阶段打卡时间
                self.cardPhase=2;
                self.preText.text = [NSString stringWithFormat:@"%@:00",detail3.workStartDatetime];
                self.lastText.text = [NSString stringWithFormat:@"%@:00",detail3.workEndDatetime];
            }
        }
        
    }
    /**************************************************/
    if ([@"8" isEqualToString:count]) {
        AttendWorkShiftDetail *detail1 = self.homeViewModel.arr[0];
        AttendWorkShiftDetail *detail2 = self.homeViewModel.arr[1];
        AttendWorkShiftDetail *detail3 = self.homeViewModel.arr[2];
        AttendWorkShiftDetail *detail4 = self.homeViewModel.arr[3];
        
        
        NSString *strCdatetime=[NSString stringWithFormat:@"%@ %@:00",curDate,detail2.workStartDatetime]; //取的第2次上班时间
        NSString *strCbeforedatetime = [LSCoreToolCenter getDateAddMinuts:strCdatetime time:-1*offSetCardArea];
        long diffC = [LSCoreToolCenter getDateDiff:curDatetime end:strCbeforedatetime];
				    
        NSString *strEdatetime=[NSString stringWithFormat:@"%@ %@:00",curDate,detail3.workStartDatetime]; //取的第3次上班时间
        NSString *strEbeforedatetime = [LSCoreToolCenter getDateAddMinuts:strEdatetime time:-1*offSetCardArea];
        long diffE = [LSCoreToolCenter getDateDiff:curDatetime end:strEbeforedatetime];
        
        long diffCE = [LSCoreToolCenter getDateDiff:strCbeforedatetime end:strEbeforedatetime]; //计算C,E点时间差
        
        
        NSString *strGdatetime=[NSString stringWithFormat:@"%@ %@:00",curDate,detail4.workStartDatetime]; //取的第4次上班时间
        NSString *strGbeforedatetime = [LSCoreToolCenter getDateAddMinuts:strGdatetime time:-1*offSetCardArea];
        long diffG = [LSCoreToolCenter getDateDiff:curDatetime end:strGbeforedatetime];
        
        long diffEG = [LSCoreToolCenter getDateDiff:strEbeforedatetime end:strGbeforedatetime]; //计算E,G点时间差
				    
        if(diffC>0){
            //显示第1阶段打卡时间
            self.cardPhase=0;
            self.preText.text = [NSString stringWithFormat:@"%@:00",detail1.workStartDatetime];
            self.lastText.text =[NSString stringWithFormat:@"%@:00",detail1.workEndDatetime]; ;
        }else{
            if(diffCE>=diffE&&diffE>0){
                //显示第2阶段打卡时间
                self.cardPhase=1;
                self.preText.text = [NSString stringWithFormat:@"%@:00",detail2.workStartDatetime];
                self.lastText.text = [NSString stringWithFormat:@"%@:00",detail2.workEndDatetime];
            }else{
                if(diffEG>=diffG&&diffG>0){
                    //显示第3阶段打卡时间
                    self.cardPhase=2;
                    self.preText.text = [NSString stringWithFormat:@"%@:00",detail3.workStartDatetime];
                    self.lastText.text = [NSString stringWithFormat:@"%@:00",detail3.workEndDatetime];
                }else{
                    //显示第4阶段打卡时间
                    self.cardPhase=3;
                    self.preText.text = [NSString stringWithFormat:@"%@:00",detail4.workStartDatetime];
                    self.lastText.text = [NSString stringWithFormat:@"%@:00",detail4.workEndDatetime];
                }
            }
        }
    }
    
    if ([LSCoreToolCenter isDayOrNight:self.preText.text]) {
        self.preImg.image = ImageNamed(@"homepage_rest_orange");
    }else{
        self.preImg.image = ImageNamed(@"homepage_work_orange");
    }
    if ([LSCoreToolCenter isDayOrNight:self.lastText.text]) {
        self.lastImg.image = ImageNamed(@"homepage_rest_green");
    }else{
        self.lastImg.image = ImageNamed(@"homepage_work_green");
    }
    
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.homeViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.homeViewModel.userCode = user.userCode;
    
    self.homeViewModel.cardDate = [LSCoreToolCenter currentYearType];
    self.homeViewModel.timePhase =[NSString stringWithFormat:@"%ld",(long)self.cardPhase];
    
    [self.homeViewModel.findAttendRecordByUserDateCommand execute:nil];
    
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

-(void)delayMethod{
    self.punch.image = ImageNamed(@"homepage_Clock_button");
}

//点击打卡
-(void)onClickImage{
    if(SIMULATOR==0){
        //开始播放/继续播放
        //        [YYAudioTool playMusic:@"msg_ding.mp3"];
        [YYAudioTool playMusic:@"Cuckoo.mp3"];
        
    }
    self.punch.image = ImageNamed(@"homepage_clock_button_press");
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.6f];
    
    
    EmpModel *empModel = self.homeViewModel.empModel;
    Dept *dept = self.homeViewModel.dept;
    NSString *locAddress =  [[NSUserDefaults standardUserDefaults] objectForKey:@"locAddress"];
    if (!empModel&&!dept) {
        return;
    }
    
    if (locAddress.length>0) {
        self.locAddress = locAddress;
    }else{
        [self setLocation];
        return;
    }
    
    if ([self.clockMode isEqualToString:@"1"]) {
        ShowErrorStatus(@"请检查网络");
        [self isNetWorking];
        return;
    }
    
    /*************************************************/
    AttendWorkShift *attendWorkShift = self.homeViewModel.attendWorkShift;
    NSString *count =  attendWorkShift.daySignCount;
    
    NSString *curDate = [LSCoreToolCenter currentYearType]; // 当前日期
    NSString *curDatetime = [LSCoreToolCenter curDate]; // 获取当前时间
    
    AttendWorkShiftDetail *detail = self.homeViewModel.arr[self.cardPhase]; //获取对应阶段打卡时间
    
    NSString *phaseStartDateTime = [NSString stringWithFormat:@"%@ %@:00",curDate,detail.workStartDatetime];//阶段开始日期时间
    NSString *phaseEndDateTime = [NSString stringWithFormat:@"%@ %@:00",curDate,detail.workEndDatetime];//阶段结束日期时间
    NSString *areaStartBefore = [LSCoreToolCenter getDateAddMinuts:phaseStartDateTime time:-1*offSetCardArea];//开始点前30分钟
    NSString *areaStartAfter = [LSCoreToolCenter getDateAddMinuts:phaseStartDateTime time:offSetCardArea]; //开始点后30分钟
    NSString *areaEndBefore = [LSCoreToolCenter getDateAddMinuts:phaseEndDateTime time:-1*offSetCardArea];//结束点前30分钟
    NSString *areaEndAfter = [LSCoreToolCenter getDateAddMinuts:phaseEndDateTime time:offSetCardArea];//结束点后30分钟
    
    
    AttendWorkShift *shift = self.homeViewModel.attendWorkShift;
    long diffLate = 1; //正数为打卡正常,负数为迟到
    long diffEarly = -1; //正数为早退,负数为正常
    NSString *isHuman = shift.isHuman;//人性化设置
    
    if([@"2" isEqualToString:isHuman]){
        NSInteger lateMinutes = [shift.allowLateMinutes  integerValue];//允许迟到n分钟
        NSInteger earlyMinutes = [shift.allowEarlyMinutes  integerValue];//允许早退n分钟
        NSString *lateTimePoint = [LSCoreToolCenter getDateAddMinuts:phaseStartDateTime time:lateMinutes]; //迟到时间点
        NSString *earlyTimePoint = [LSCoreToolCenter getDateAddMinuts:phaseEndDateTime time:-1*earlyMinutes]; //早退时间点
        
        diffLate = [LSCoreToolCenter getDateDiff:curDatetime end:lateTimePoint];
        diffEarly = [LSCoreToolCenter getDateDiff:curDatetime end:earlyTimePoint];
        
    }
    long diffM11 = [LSCoreToolCenter getDateDiff:curDatetime end:areaStartBefore];
    long diffM12 = [LSCoreToolCenter getDateDiff:curDatetime end:areaStartAfter];
    long diffM21 = [LSCoreToolCenter getDateDiff:curDatetime end:areaEndBefore];
    long diffM22 = [LSCoreToolCenter getDateDiff:curDatetime end:areaEndAfter];
    
    switch (self.cardPhase) {
        case 0: { //A,B
            //----------------------------------------------------------------------
            if(diffM11>0){
                
                self.retCode=-1;
                self.timePoint=1;
            }else{
                if(diffM12>=0){
                    //================================================
                    if(diffLate>=0){
                        
                        //A点打卡时间,正常!
                        self.retCode=0;
                        self.timePoint=1;
                    }else{
                        //A点打卡时间,迟到!
                        self.retCode=2;
                        self.timePoint=1;
                    }
                    //================================================
                }else{
                    //超过A点打卡时间!
                    if(diffM21>0){
                        //不到B点打卡时间!
                        self.retCode=-1;
                        self.timePoint=2;
                    }else{
                        if(diffM22>=0){
                            if(diffEarly<=0){
                                //B点打卡时间! 正常
                                self.retCode=0;
                                self.timePoint=2;
                            }else{
                                //B点打卡时间! 早退
                                self.retCode=1;
                                self.timePoint=2;
                            }
                        }else{
                            //超过B点打卡时间!
                            self.retCode=3;
                            self.timePoint=2;
                        }
                    }
                }
            }
            //----------------------------------------------------------------------
            break;
        }
        case 1: {//C,D
            //----------------------------------------------------------------------
            if(diffM11>0){
                //不到C点打卡时间!
                self.retCode=-1;
                self.timePoint=3;
            }else{
                if(diffM12>=0){
                    //================================================
                    if(diffLate>=0){
                        //C点打卡时间,正常!
                        self.retCode=0;
                        self.timePoint=3;
                    }else{
                        //C点打卡时间,迟到!
                        self.retCode=2;
                        self.timePoint=3;
                    }
                    //================================================
                }else{
                    //超过C点打卡时间!
                    if(diffM21>0){
                        //不到D点打卡时间!
                        self.retCode=-1;
                        self.timePoint=4;
                    }else{
                        if(diffM22>=0){
                            if(diffEarly<=0){
                                //D点打卡时间! 正常
                                self.retCode=0;
                                self.timePoint=4;
                            }else{
                                //D点打卡时间! 早退
                                self.retCode=1;
                                self.timePoint=4;
                            }
                        }else{
                            //超过D点打卡时间!
                            self.retCode=3;
                            self.timePoint=4;
                        }
                    }
                }
            }
            //----------------------------------------------------------------------
            break;
        }
        case 2: {//E,F
            //----------------------------------------------------------------------
            if(diffM11>0){
                //不到E点打卡时间!
                self.retCode=-1;
                self.timePoint=5;
            }else{
                if(diffM12>=0){
                    //================================================
                    if(diffLate>=0){
                        //E点打卡时间,正常!
                        self.retCode=0;
                        self.timePoint=5;
                    }else{
                        //E点打卡时间,迟到!
                        self.retCode=2;
                        self.timePoint=5;
                    }
                    //================================================
                }else{
                    //超过E点打卡时间!
                    if(diffM21>0){
                        //不到F点打卡时间!
                        self.retCode=-1;
                        self.timePoint=6;
                    }else{
                        if(diffM22>=0){
                            if(diffEarly<=0){
                                //F点打卡时间! 正常
                                self.retCode=0;
                                self.timePoint=6;
                            }else{
                                //F点打卡时间! 早退
                                self.retCode=1;
                                self.timePoint=6;
                            }
                        }else{
                            //超过F点打卡时间!
                            self.retCode=3;
                            self.timePoint=6;
                        }
                    }
                }
            }
            //----------------------------------------------------------------------
            break;
        }
        case 3: {//G,H
            //----------------------------------------------------------------------
            if(diffM11>0){
                //不到G点打卡时间!
                self.retCode=-1;
                self.timePoint=7;
            }else{
                if(diffM12>=0){
                    //================================================
                    if(diffLate>=0){
                        //G点打卡时间,正常!
                        self.retCode=0;
                        self.timePoint=7;
                    }else{
                        //G点打卡时间,迟到!
                        self.retCode=2;
                        self.timePoint=7;
                    }
                    //================================================
                }else{
                    //超过G点打卡时间!
                    if(diffM21>0){
                        //不到H点打卡时间!
                        self.retCode=-1;
                        self.timePoint=8;
                    }else{
                        if(diffM22>=0){
                            if(diffEarly<=0){
                                //H点打卡时间! 正常
                                self.retCode=0;
                                self.timePoint=8;
                            }else{
                                //H点打卡时间! 早退
                                self.retCode=1;
                                self.timePoint=8;
                            }
                        }else{
                            //超过H点打卡时间!
                            self.retCode=3;
                            self.timePoint=8;
                        }
                    }
                }
            }
            //----------------------------------------------------------------------
            break;
        }
    }
    
    
    //==================================================
    if(self.retCode==-1){
        //        RingUtil.playLocalSound(R.raw.oper_error);
        if(SIMULATOR==0){
            [YYAudioTool playMusic:@"oper_error.mp3"];
        }
        ShowMessage(@"还不到打卡时间!");
        return;
    }
    if(self.retCode==0){
        
    }
    if(self.retCode==1){
        
        ShowMessage(@"不到下班时间,您早退了!");
    }
    if(self.retCode==2){
        
        
        ShowMessage(@"超过上班时间,您迟到了!");
    }
    if(self.retCode==3){
        //        RingUtil.playLocalSound(R.raw.oper_error);
        if(SIMULATOR==0){
            [YYAudioTool playMusic:@"oper_error.mp3"];
        }
        ShowMessage(@"超过打卡时间了!");
        return;
    }
    
    
    
    /*************************************************/
    
    
    //self.punch.userInteractionEnabled = NO;
    
    //关闭定时器
    [self.timeNow setFireDate:[NSDate distantFuture]];
    
    NSString *timetmp = [self.formatter stringFromDate:[NSDate date]];
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.homeViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.homeViewModel.userCode = user.userCode;
    self.homeViewModel.cardDate = [LSCoreToolCenter currentYearType];
    self.homeViewModel.cardTime = timetmp;
    self.homeViewModel.cardDeviceType = @"IOS";
    self.homeViewModel.cardDeviceName = [LSCoreToolCenter deviceVersion];
    self.homeViewModel.empCode = empModel.empCode;
    self.homeViewModel.userName = empModel.empName;
    self.homeViewModel.deptCode = empModel.deptCode;
    self.homeViewModel.deptName = dept.deptFullName;
    self.homeViewModel.locLongitude = self.locLongitude;
    self.homeViewModel.locLatitude = self.locLatitude;
    if(SIMULATOR == 1){
        self.homeViewModel.locLongitude = @"1.0000";
        self.homeViewModel.locLatitude = @"1.0000";;
    }
    
    self.homeViewModel.locAddress = self.locAddress;
    self.homeViewModel.clockMode = self.clockMode;
    self.homeViewModel.timePhase =[NSString stringWithFormat:@"%ld",(long)self.cardPhase] ;
    self.homeViewModel.timePoint = [NSString stringWithFormat:@"%ld",(long)self.timePoint];
    self.homeViewModel.cardStatus = [NSString stringWithFormat:@"%ld",(long)self.retCode];
    
    [self.homeViewModel.attendRecordCommand execute:nil];
    
}


#pragma mark lazyload
-(HomeViewModel *)homeViewModel{
    if (!_homeViewModel) {
        _homeViewModel = [[HomeViewModel alloc] init];
    }
    return _homeViewModel;
}

-(BMKLocationService *)locService{
    if (!_locService) {
        
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
        // 设置定位精确度到米
        _locService.desiredAccuracy = kCLLocationAccuracyBest;
        // 设置过滤器为无
        //        _locService.distanceFilter = kCLDistanceFilterNone;
        
        _locService.distanceFilter=10;
    }
    return _locService;
    
}


-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"";
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
        _name.text = @"";
        _name.font = H14;
        
    }
    return _name;
}

-(UILabel *)department{
    if (!_department) {
        _department = [[UILabel alloc] init];
        _department.text = @"";
        
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
        _netStatusText.text = @"当前网络状态";
        _netStatusText.font = H18;
        _netStatusText.textColor = RGBCOLOR(131, 131, 131);
    }
    return _netStatusText;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        if (isPad) {
            _scrollView.scrollEnabled = YES;
        }else{
            _scrollView.scrollEnabled = NO;
        }
    }
    return _scrollView;
}

-(UIImageView *)bg{
    if (!_bg) {
        _bg = [[UIImageView alloc] init];
        //        _bg.image = ImageNamedBg;
    }
    return _bg;
}


@end
