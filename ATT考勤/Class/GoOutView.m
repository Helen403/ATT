//
//  GoOutView.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "GoOutView.h"
#import "ApplyManView.h"
#import "ProveView.h"
#import "GoOutViewModel.h"
#import "JSTextView.h"


#import "XHDatePickerView.h"
#import "NSDate+Extension.h"
#import "ApplyManViewModel.h"
#import "TeamListModel.h"
#import "UserModel.h"

#import "GoOutCellView.h"

//#import "BMKLocationService.h"
#import "ProveModel.h"

@interface GoOutView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) GoOutViewModel *goOutViewModel;

@property(nonatomic,strong) UILabel *applyTimeText;

@property(nonatomic,strong) UILabel *applyTimeShowText;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UILabel *lateTimeText;

@property(nonatomic,strong) UILabel *lateTimeShowText;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UILabel *sureTimeText;

@property(nonatomic,strong) UITextField *sureTimeShowText;

@property(nonatomic,strong) UIView *line3;

@property(nonatomic,strong) JSTextView *textView;

@property(nonatomic,strong) ProveView *proveView;

@property(nonatomic,strong) ApplyManView *applyManView;

@property(nonatomic,strong) UIButton *finish;

@property(nonatomic,strong) UILabel *compensateText;

@property(nonatomic,strong) UILabel *compensateShowText;

@property(nonatomic,strong) UIView *line4;

//@property(nonatomic,strong) UIImageView *back1;

@property(nonatomic,strong) UIImageView *back2;

@property(nonatomic,strong) UIView *view1;

@property(nonatomic,strong) UIView *view2;


@property(nonatomic,strong) UIScrollView *scrollView;


@property(nonatomic,strong) ApplyManViewModel *applyManViewModel;

@property(nonatomic,strong) UIView *timeView1;

@property(nonatomic,strong) UIView *timeView2;

@property(nonatomic,strong) XHDatePickerView *datepicker;

@property(nonatomic,strong) NSString *cuserCode;

@property(nonatomic,strong) NSString *cuserName;

@property(nonatomic,strong) NSString *workLsh;

@property(nonatomic,strong) UITableView *tableView;

//@property(nonatomic,strong) BMKLocationService *locService;

@property(nonatomic,strong) NSString *stepUserCodes;

@property(nonatomic,strong) NSString *stepUserNames;

@property(nonatomic,strong) NSString *flowInstanceId;

@end


@implementation GoOutView


#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.goOutViewModel = (GoOutViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    
    CGFloat padding = [self h_w:15];
    CGFloat length = [self h_w:160];
    
    [self.timeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:48]));
    }];
    
    [self.timeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timeView1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:48]));
        make.top.equalTo(weakSelf.timeView1.mas_bottom).offset(0);
    }];
    
    
    
    [self.applyTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo(padding);
    }];
    
  
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.applyTimeText.mas_bottom).offset(padding);
       make.centerX.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-[self h_w:20], [self h_w:1]));
    }];
    
    [self.applyTimeShowText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.line1);
        make.centerY.equalTo(weakSelf.applyTimeText);
    }];
    
    [self.lateTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.applyTimeText);
    }];
    
    [self.lateTimeShowText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lateTimeText);
        make.left.equalTo(weakSelf.applyTimeShowText);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lateTimeText.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line2.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:45]));
    }];
    
    [self.sureTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view1);
        make.left.equalTo(weakSelf.applyTimeText);
    }];
    
//    [self.back1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.view1);
//        make.right.equalTo(0);
//    }];
    
    [self.sureTimeShowText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
        make.centerY.equalTo(weakSelf.view1);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view1).offset(0);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view1.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:45]));
    }];
    
    [self.compensateText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view2);
        make.left.equalTo(weakSelf.applyTimeText);
    }];
    
    
    
    [self.back2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view2);
        make.right.equalTo(0);
    }];
    
    [self.compensateShowText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.back2.mas_left).offset(-[self h_w:10]);
        make.centerY.equalTo(weakSelf.view2);
    }];
    
    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view2).offset(0);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view2.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:120]));
    }];
    
    [self.applyManView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textView.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, length*0.5));
    }];
    
    [self.proveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.applyManView.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, length*0.5));
    }];
    
    [self.finish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.proveView.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.finish.mas_bottom).offset([self h_w:20]);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.scrollView];
    
    
    
    [self.scrollView addSubview:self.timeView1];
    [self.scrollView addSubview:self.timeView2];
    [self.scrollView addSubview:self.applyTimeText];
    [self.scrollView addSubview:self.applyTimeShowText];
    [self.scrollView addSubview:self.line1];
    [self.scrollView addSubview:self.lateTimeText];
    [self.scrollView addSubview:self.lateTimeShowText];
    [self.scrollView addSubview:self.line2];
    [self.scrollView addSubview:self.view1];
    [self.scrollView addSubview:self.view2];
    
    [self.view1 addSubview:self.sureTimeText];
    [self.view1 addSubview:self.sureTimeShowText];
//    [self.view1 addSubview:self.back1];
    [self.view1 addSubview:self.line3];
    
    [self.view2 addSubview:self.compensateText];
    [self.view2 addSubview:self.compensateShowText];
    [self.view2 addSubview:self.back2];
    [self.view2 addSubview:self.line4];
    
    [self.scrollView addSubview:self.textView];
    [self.scrollView addSubview:self.proveView];
    [self.scrollView addSubview:self.applyManView];
    [self.scrollView addSubview:self.finish];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_loadData{
    
    //设置时间
    self.applyTimeShowText.text = [LSCoreToolCenter currentYearYMDHM];
    self.lateTimeShowText.text = [LSCoreToolCenter currentYearYMDHM];
    
    self.cuserCode = @"";
    self.cuserName = @"";
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.goOutViewModel.companyCode = companyCode;
    [self.goOutViewModel.refreshDataCommand execute:nil];
    //定位
//    [self.locService startUserLocationService];
}


-(void)h_bindViewModel{
    [[self.goOutViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.8, [self h_w:40]*self.goOutViewModel.arr.count);
            [self.tableView reloadData];
            if (self.goOutViewModel.arr.count == 0) {
                return ;
            }
            GoOutModel *goOut = self.goOutViewModel.arr[0];
            self.compensateShowText.text = goOut.workName;
            //            self.workLsh = leave.workLsh;
            
        });
    }];
    
    [[self.goOutViewModel.flowTemplateSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *x) {
        
        self.flowInstanceId = x;
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyManViewRefresh:) name:@"ApplyManView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ProveView:) name:@"ProveView" object:nil];
}

-(void)ProveView:(NSNotification*) notification{
    NSMutableArray *arrTemp = [notification object];
    
    self.stepUserCodes = @"";
    self.stepUserNames = @"";
    if (arrTemp.count==0) {
        return;
    }
    for (ProveModel *prove in arrTemp) {
        
        self.stepUserCodes = [NSString stringWithFormat:@"%@,%@",self.stepUserCodes,prove.whoisId];
        self.stepUserNames = [NSString stringWithFormat:@"%@,%@",self.stepUserNames,prove.whois];
    }
    
    self.stepUserCodes = [self.stepUserCodes substringFromIndex:1];
    self.stepUserNames = [self.stepUserNames substringFromIndex:1];
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.goOutViewModel.companyCode = companyCode;
    self.goOutViewModel.flowTypeName = @"goOutWork";
    self.goOutViewModel.stepUserCodes= self.stepUserCodes;
    self.goOutViewModel.stepUserNames = self.stepUserNames;
    [self.goOutViewModel.flowTemplateCommand execute:nil];
}

-(void)applyManViewRefresh:(NSNotification*) notification{
    NSMutableArray *arrTemp = [notification object];
    
    for(int i = 0;i<arrTemp.count;i++){
        TeamListModel *teamList = arrTemp[i];
        self.cuserCode = [NSString stringWithFormat:@"%@,%@",self.cuserCode,teamList.empCode];
        self.cuserName = [NSString stringWithFormat:@"%@,%@",self.cuserName,teamList.empName];
    }
    
//    self.cuserCode = [self.cuserCode substringFromIndex:1];
    self.cuserName = [self.cuserName substringFromIndex:1];
}




#pragma mark lazyload
-(GoOutViewModel *)goOutViewModel{
    if (!_goOutViewModel) {
        _goOutViewModel = [[GoOutViewModel alloc] init];
    }
    return _goOutViewModel;
}


-(XHDatePickerView *)datepicker{
    if (!_datepicker) {
        _datepicker =  [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate,NSDate *endDate) {
            
            NSString *startDateText = [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            NSString *endDateText = [endDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            
            if (startDateText.length > 0) {
                
                NSString *str =[NSString stringWithFormat:@"%f",[LSCoreToolCenter getDifferenceTime:startDateText endTime:self.lateTimeShowText.text]];
                if (str.doubleValue>0) {
                    self.applyTimeShowText.text = startDateText;
                }else{
                    ShowMessage(@"请选择正确时间");
                }
                
            }
            
            if (endDateText.length > 0 ) {
                
                NSString *str =[NSString stringWithFormat:@"%f",[LSCoreToolCenter getDifferenceTime:self.applyTimeShowText.text endTime:endDateText]];
                if (str.doubleValue>0) {
                    self.lateTimeShowText.text = endDateText;
                }else{
                    ShowMessage(@"请选择正确时间");
                }
            }
            
            
        }];
        _datepicker.datePickerStyle = DateStyleShowYearMonthDayHourMinute;
        _datepicker.dateType = DateTypeStartDate;
        _datepicker.minLimitDate = [NSDate date:@"2017-02-01 12:22" WithFormat:@"yyyy-MM-dd HH:mm"];
        _datepicker.maxLimitDate = [NSDate date:@"2020-12-12 12:12" WithFormat:@"yyyy-MM-dd HH:mm"];    }
    return _datepicker;
}


-(UIView *)timeView1{
    if (!_timeView1) {
        _timeView1 = [[UIView alloc] init];
        
        _timeView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeClick1)];
        [_timeView1 addGestureRecognizer:setTap];
    }
    return _timeView1;
}

-(void)timeClick1{
    _datepicker = nil;
    [self.datepicker show];
}

-(UIView *)timeView2{
    if (!_timeView2) {
        _timeView2 = [[UIView alloc] init];
        
        _timeView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeClick2)];
        [_timeView2 addGestureRecognizer:setTap];
    }
    return _timeView2;
}

-(void)timeClick2{
    _datepicker = nil;
    [self.datepicker show];
}


-(UILabel *)applyTimeText{
    if (!_applyTimeText) {
        _applyTimeText = [[UILabel alloc] init];
        _applyTimeText.text = @"开始时间";
        _applyTimeText.textColor = MAIN_PAN_2;
        _applyTimeText.font = H14;
    }
    return _applyTimeText;
}

-(UILabel *)applyTimeShowText{
    if (!_applyTimeShowText) {
        _applyTimeShowText = [[UILabel alloc] init];
        _applyTimeShowText.text = @"";
        _applyTimeShowText.font = H14;
        _applyTimeShowText.textColor = MAIN_PAN_2;
    }
    return _applyTimeShowText;
}

-(UIView *)line1{
    
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line1;
}

-(UILabel *)lateTimeText{
    if (!_lateTimeText) {
        _lateTimeText = [[UILabel alloc] init];
        _lateTimeText.text = @"结束时间";
        _lateTimeText.textColor = MAIN_PAN_2;
        _lateTimeText.font = H14;
    }
    return _lateTimeText;
}

-(UILabel *)lateTimeShowText{
    if (!_lateTimeShowText) {
        _lateTimeShowText = [[UILabel alloc] init];
        _lateTimeShowText.text = @"";
        _lateTimeShowText.font = H14;
        _lateTimeShowText.textColor = MAIN_PAN_2;
    }
    return _lateTimeShowText;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line2;
}

-(UILabel *)sureTimeText{
    if (!_sureTimeText) {
        _sureTimeText = [[UILabel alloc] init];
        _sureTimeText.text = @"外出地点";
        _sureTimeText.textColor = MAIN_PAN_2;
        _sureTimeText.font = H14;
    }
    return _sureTimeText;
    
}

-(UITextField *)sureTimeShowText{
    if (!_sureTimeShowText) {
        _sureTimeShowText = [[UITextField alloc] init];
        _sureTimeShowText.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _sureTimeShowText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _sureTimeShowText.textAlignment = NSTextAlignmentRight;
        
        //当输入框没有内容时，水印提示 提示内容为password
        _sureTimeShowText.placeholder = @"外出地点";
        _sureTimeShowText.tintColor = MAIN_PAN_2;
        _sureTimeShowText.textColor = MAIN_PAN_2;
        //修改account的placeholder的字体颜色、大小
        [_sureTimeShowText setValue: MAIN_TEXTFIELD forKeyPath:@"_placeholderLabel.textColor"];
        [_sureTimeShowText setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _sureTimeShowText.font = H14;
        // 设置右边永远显示清除按钮
        //        _sureTimeShowText.clearButtonMode = UITextFieldViewModeAlways;
        _sureTimeShowText.keyboardType = UIKeyboardTypePhonePad;
        // 5.监听文本框的文字改变
//        _sureTimeShowText.delegate = self;
    }
    return _sureTimeShowText;
}

-(UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line3;
}

-(JSTextView *)textView{
    if (!_textView) {
        _textView  = [[JSTextView alloc] init];
        //        _textView.backgroundColor = yellow_color;
        
        _textView.scrollEnabled = NO;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
        _textView.editable = YES;        //是否允许编辑内容，默认为“YES”
        //        _textView.delegate = self;       //设置代理方法的实现类
        _textView.font=[UIFont fontWithName:@"Arial" size:18.0]; //设置字体名字和字体大小;
        //        _textView.returnKeyType = UIReturnKeyDefault;//return键的类型
        //        _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _textView.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        _textView.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
        _textView.textColor = MAIN_PAN_2;

        _textView.myPlaceholder = @"外出理由";
        _textView.myPlaceholderColor = [UIColor lightGrayColor];
        
        _textView.layer.borderColor = MAIN_LINE_COLOR.CGColor;
        _textView.layer.borderWidth =1.0;
        _textView.layer.cornerRadius =5.0;
        _textView.font = H14;
        
    }
    return _textView;
}

-(ProveView *)proveView{
    if (!_proveView) {
        _proveView = [[ProveView alloc] init];
        _proveView.layer.borderColor = MAIN_LINE_COLOR.CGColor;
        _proveView.layer.borderWidth =1.0;
        _proveView.layer.cornerRadius =5.0;
        _proveView.flowType = @"goOutWork";
    }
    return _proveView;
}

-(ApplyManView *)applyManView{
    if (!_applyManView) {
        _applyManView = [[ApplyManView alloc] initWithViewModel:self.applyManViewModel];
        
        _applyManView.layer.borderColor = MAIN_LINE_COLOR.CGColor;
        _applyManView.layer.borderWidth = 1.0;
        _applyManView.layer.cornerRadius = 5.0;
    }
    return _applyManView;
}

-(ApplyManViewModel *)applyManViewModel{
    if (!_applyManViewModel) {
        _applyManViewModel = [[ApplyManViewModel alloc] init];
    }
    return _applyManViewModel;
}

-(UIButton *)finish{
    if (!_finish) {
        _finish = [[UIButton alloc] init];
        [_finish setTitle:@"提交申请" forState:UIControlStateNormal];
        _finish.titleLabel.font = H22;
        [_finish addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
        
        [_finish.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_finish.layer setCornerRadius:10];
        
        [_finish.layer setBorderWidth:2];//设置边界的宽度
        
        [_finish setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色

        [_finish.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    
    return _finish;
}

-(void)finish:(UIButton *)button{
    
    if ([self.applyTimeShowText.text isEqualToString:self.lateTimeShowText.text]) {
        ShowMessage(@"请选择出差时间");
        return;
    }
    
    if (self.sureTimeShowText.text.length==0) {
        ShowMessage(@"请输入外出地点");
        //定位
//        [self.locService startUserLocationService];
        return;
    }
    
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.goOutViewModel.companyCode = companyCode;
    self.goOutViewModel.applyStartDatetime = self.applyTimeShowText.text;
    self.goOutViewModel.applyEndDatetime = self.lateTimeShowText.text;
    self.goOutViewModel.applyLenHours = [NSString stringWithFormat:@"%f",[LSCoreToolCenter getDifferenceTime:self.applyTimeShowText.text endTime:self.lateTimeShowText.text]];
    
    self.goOutViewModel.applyReason = self.textView.text;
    self.goOutViewModel.applyStatus = @"0";
    self.goOutViewModel.flowInstanceId = self.flowInstanceId;
    self.goOutViewModel.cuserCode = self.cuserCode;
    self.goOutViewModel.cuserName = self.cuserName;
    
    self.goOutViewModel.outAddress = self.sureTimeShowText.text;
    self.goOutViewModel.outtype = self.compensateShowText.text;
    
    self.goOutViewModel.workLsh = self.workLsh;
    self.goOutViewModel.workName = self.sureTimeShowText.text;
    UserModel *user =  getModel(@"user");
    self.goOutViewModel.applyUserCode = user.userCode;
    self.goOutViewModel.applyUserName = user.userNickName;
    
    [self.goOutViewModel.applyGoOutWorkCommand execute:nil];
}



-(UILabel *)compensateText{
    if (!_compensateText) {
        _compensateText = [[UILabel alloc] init];
        _compensateText.text = @"外出类型";
        _compensateText.font = H14;
        _compensateText.textColor = MAIN_PAN_2;
    }
    return _compensateText;
}

-(UILabel *)compensateShowText{
    if (!_compensateShowText) {
        _compensateShowText = [[UILabel alloc] init];
        _compensateShowText.text = @"";
        _compensateShowText.font = H14;
        _compensateShowText.textColor = MAIN_PAN_2;
    }
    return _compensateShowText;
}

//-(UIImageView *)back1{
//    if (!_back1) {
//        _back1 = [[UIImageView alloc] init];
//        _back1.image = ImageNamed(@"role_right_arrow");
//    }
//    return _back1;
//}

-(UIImageView *)back2{
    if (!_back2) {
        _back2 = [[UIImageView alloc] init];
        _back2.image = ImageNamed(@"role_right_arrow");
    }
    return _back2;
}

-(UIView *)view1{
    if (!_view1) {
        _view1 = [[UIView alloc] init];
    }
    return _view1;
}


-(UIView *)view2{
    if (!_view2) {
        _view2 = [[UIView alloc] init];
        _view2.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
        [_view2 addGestureRecognizer:setTap];
    }
    return _view2;
}

-(void)click{
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
    [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
    [[HWPopTool sharedInstance] showWithPresentView:self.tableView animated:NO];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[GoOutCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([GoOutCellView class])]];
        _tableView.scrollEnabled = NO;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self h_w:40])];
        view.backgroundColor = white_color;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake([self h_w:10], 0, SCREEN_WIDTH, [self h_w:40])];
        title.text = @"请选择";
        title.font = H14;
        title.textColor = MAIN_PAN_2;
        [view addSubview:title];
        title.centerY = [self h_w:20];
        _tableView.tableHeaderView = view;
        ViewRadius(_tableView, 5);
    }
    return _tableView;
}

#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.goOutViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoOutCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([GoOutCellView class])] forIndexPath:indexPath];
    
    cell.goOutModel = self.goOutViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoOutModel *goOutModel =  self.goOutViewModel.arr[indexPath.row];
    self.compensateShowText.text = goOutModel.workName;
    self.workLsh = goOutModel.workLsh;
    [[HWPopTool sharedInstance] closeWithBlcok:^{
        [self.tableView reloadData];
    }];
}

-(UIView *)line4{
    if (!_line4) {
        _line4 = [[UIView alloc] init];
        _line4.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line4;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

//
//-(BMKLocationService *)locService{
//    if (!_locService) {
//        
//        _locService = [[BMKLocationService alloc] init];
//        _locService.delegate = self;
//        // 设置定位精确度到米
//        _locService.desiredAccuracy = kCLLocationAccuracyBest;
//        // 设置过滤器为无
//        //        _locService.distanceFilter = kCLDistanceFilterNone;
//        
//        _locService.distanceFilter=10;
//    }
//    return _locService;
//}
//
//
////实现相关delegate 处理位置信息更新
////处理方向变更信息
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
//    //NSLog(@"heading is %@",userLocation.heading);
//}
////处理位置坐标更新
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    
//    
//    //    ShowMessage(@"定位成功");
//    //    NSString *currentLatitude = [[NSString alloc]
//    //                                 initWithFormat:@"%f",
//    //                                 userLocation.location.coordinate.latitude];
//    //
//    //    NSString *currentLongitude = [[NSString alloc]
//    //                                  initWithFormat:@"%f",
//    //                                  userLocation.location.coordinate.longitude];
//    
//    //    self.locLongitude = currentLongitude;
//    //
//    //    self.locLatitude = currentLatitude;
//    
//    
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
//        if (array.count > 0) {
//            CLPlacemark *placemark = [array objectAtIndex:0];
//            if (placemark != nil) {
//                //                NSString *city = placemark.locality;
//                //                //                NSLog(@"%@",city);
//                //                NSString *city1 = placemark.name;
//                //                //                NSLog(@"%@",city1);
//                //                self.locAddress = [NSString stringWithFormat:@"%@%@",city,city1];
//                NSDictionary *city2 = placemark.addressDictionary;
//                //                NSLog(@"%@",city2);
//                NSArray *dict = city2[@"FormattedAddressLines"];
//                NSString *str =  [dict objectAtIndex:0];
//                //                NSLog(@"%@",str);
//                //                NSString *city3 = placemark.region;
//                //                NSLog(@"%@",city3);
//                //找到了当前位置城市后就关闭服务
//                
//                self.sureTimeShowText.text = str;
//                
//                //                [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"locAddress"];
//                
//                [self.locService stopUserLocationService];
//                
//            }
//        }
//    }];
//    
//}


-(void)dealloc{
    [[NSNotificationCenter  defaultCenter] removeObserver:self  name:@"ApplyManView" object:nil];
    [[NSNotificationCenter  defaultCenter] removeObserver:self  name:@"ProveView" object:nil];
}

@end
