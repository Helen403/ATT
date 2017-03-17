//
//  ResignationView.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ResignationView.h"
#import "ResignationViewModel.h"
#import "ProveView.h"
#import "ApplyManView.h"
#import "JSTextView.h"
#import "XHDatePickerView.h"
#import "NSDate+Extension.h"
#import "ApplyManViewModel.h"
#import "TeamListModel.h"
#import "UserModel.h"
#import "ResignationCellView.h"
#import "ResignationModel.h"
#import "ProveModel.h"

@interface ResignationView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) ResignationViewModel *resignationViewModel;

@property(nonatomic,strong) UILabel *applyTimeText;

@property(nonatomic,strong) UILabel *applyTimeShowText;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UILabel *lateTimeText;

@property(nonatomic,strong) UILabel *lateTimeShowText;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UILabel *sureTimeText;

@property(nonatomic,strong) UILabel *sureTimeShowText;

@property(nonatomic,strong) UIView *line3;

@property(nonatomic,strong) JSTextView *textView;

@property(nonatomic,strong) ProveView *proveView;

@property(nonatomic,strong) ApplyManView *applyManView;

@property(nonatomic,strong) UIButton *finish;

@property(nonatomic,strong) UIImageView *back;

@property(nonatomic,strong) UIView *view;

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) ApplyManViewModel *applyManViewModel;

@property(nonatomic,strong) UIView *timeView1;

@property(nonatomic,strong) UIView *timeView2;

@property(nonatomic,strong) XHDatePickerView *datepicker;

@property(nonatomic,strong) NSString *cuserCode;

@property(nonatomic,strong) NSString *cuserName;

@property(nonatomic,strong) NSString *workLsh;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,assign) NSInteger index;

@property(nonatomic,strong) NSString *shiftOldLsh;

@property(nonatomic,strong) NSString *shiftNewLsh;

@property(nonatomic,strong) NSString *stepUserCodes;

@property(nonatomic,strong) NSString *stepUserNames;

@property(nonatomic,strong) NSString *flowInstanceId;



@end

@implementation ResignationView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.resignationViewModel = (ResignationViewModel *)viewModel;
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
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line2.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.applyTimeText);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:45]));
    }];
    
    [self.sureTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.line1);
    }];
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.line1);
    }];
    
    [self.sureTimeShowText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.back.mas_left).offset(-[self h_w:10]);
        make.centerY.equalTo(weakSelf.view);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
        
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line3.mas_bottom).offset(padding);
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
    
    [self.scrollView addSubview:self.line3];
    [self.scrollView addSubview:self.textView];
    [self.scrollView addSubview:self.proveView];
    [self.scrollView addSubview:self.applyManView];
    [self.scrollView addSubview:self.finish];
    
    
    [self.scrollView addSubview:self.view];
    [self.view addSubview:self.sureTimeText];
    [self.view addSubview:self.sureTimeShowText];
    [self.view addSubview:self.back];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_loadData{
    
    self.index = 0;
    
    //设置时间
    self.applyTimeShowText.text = [LSCoreToolCenter currentYearYMDHM];
    self.lateTimeShowText.text = [LSCoreToolCenter currentYearYMDHM];
    
    self.cuserCode = @"";
    self.cuserName = @"";
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.resignationViewModel.companyCode = companyCode;
    [self.resignationViewModel.refreshDataCommand execute:nil];
    
}


-(void)h_bindViewModel{
    [[self.resignationViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.8, [self h_w:40]*self.resignationViewModel.arr.count);
            [self.tableView reloadData];
            if (self.resignationViewModel.arr.count==0) {
                return ;
            }
            ResignationModel *Resignation = self.resignationViewModel.arr[0];
            self.sureTimeShowText.text = Resignation.workName;
            self.workLsh = Resignation.workLsh;
            
            //            self.compensateShowText.text = move.shiftName;
            //            self.shiftOldLsh = move.shiftLsh;
            //            self.shiftNewLsh = move.shiftLsh;
            
        });
    }];
    
    
    [[self.resignationViewModel.flowTemplateSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *x) {
        
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
    self.resignationViewModel.companyCode = companyCode;
    self.resignationViewModel.flowTypeName = @"leaveWork";
    self.resignationViewModel.stepUserCodes= self.stepUserCodes;
    self.resignationViewModel.stepUserNames = self.stepUserNames;
    [self.resignationViewModel.flowTemplateCommand execute:nil];
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
-(ResignationViewModel *)resignationViewModel{
    if (!_resignationViewModel) {
        _resignationViewModel = [[ResignationViewModel alloc] init];
    }
    return _resignationViewModel;
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
        _applyTimeText.text = @"递交申请时间";
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
        _lateTimeText.text = @"辞职时间";
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
        _sureTimeText.text = @"辞职形式";
        _sureTimeText.textColor = MAIN_PAN_2;
        _sureTimeText.font = H14;
    }
    return _sureTimeText;
    
}

-(UILabel *)sureTimeShowText{
    if (!_sureTimeShowText) {
        _sureTimeShowText = [[UILabel alloc] init];
        _sureTimeShowText.text = @"";
        _sureTimeShowText.font = H14;
        _sureTimeShowText.textColor = MAIN_PAN_2;
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
        
        
        _textView.myPlaceholder = @"辞职理由";
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
        _proveView.flowType = @"leaveWork";
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
    
//    if ([self.applyTimeShowText.text isEqualToString:self.lateTimeShowText.text]) {
//        ShowMessage(@"请选择辞职时间");
//        return;
//    }

    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.resignationViewModel.companyCode = companyCode;
    self.resignationViewModel.applyStartDatetime = self.applyTimeShowText.text;
    self.resignationViewModel.applyEndDatetime = self.lateTimeShowText.text;
    self.resignationViewModel.applyLenHours = [NSString stringWithFormat:@"%f",[LSCoreToolCenter getDifferenceTime:self.applyTimeShowText.text endTime:self.lateTimeShowText.text]];
    
    self.resignationViewModel.applyReason = self.textView.text;
    self.resignationViewModel.applyStatus = @"0";
    self.resignationViewModel.flowInstanceId = self.flowInstanceId;
    self.resignationViewModel.cuserCode = self.cuserCode;
    self.resignationViewModel.cuserName = self.cuserName;
    
    
    self.resignationViewModel.changeDatetime =[NSString stringWithFormat:@"%f",[LSCoreToolCenter getDifferenceTime:self.applyTimeShowText.text endTime:self.lateTimeShowText.text]];
    
    self.resignationViewModel.shiftOldLsh = self.shiftOldLsh;
    self.resignationViewModel.shiftOldName = self.sureTimeShowText.text;

    
    self.resignationViewModel.workLsh = self.workLsh;
    self.resignationViewModel.workName = self.sureTimeShowText.text;
    UserModel *user =  getModel(@"user");
    self.resignationViewModel.applyUserCode = user.userCode;
    self.resignationViewModel.applyUserName = user.userNickName;
    
    [self.resignationViewModel.applyLeaveCommand execute:nil];
}


-(UIImageView *)back{
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = ImageNamed(@"role_right_arrow");
    }
    return _back;
}

-(UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] init];
        _view.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click1)];
        [_view addGestureRecognizer:setTap];
    }
    return _view;
}

-(void)click1{
    
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
        [_tableView registerClass:[ResignationCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ResignationCellView class])]];
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
    
    return self.resignationViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResignationCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ResignationCellView class])] forIndexPath:indexPath];
    
    cell.resignationModel = self.resignationViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResignationModel *resignation = self.resignationViewModel.arr[indexPath.row];
    
    self.sureTimeShowText.text = resignation.workName;
    
    self.workLsh = resignation.workLsh;
    [[HWPopTool sharedInstance] closeWithBlcok:^{
        [self.tableView reloadData];
    }];
}


-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

-(void)dealloc{
    [[NSNotificationCenter  defaultCenter] removeObserver:self  name:@"ApplyManView" object:nil];
    [[NSNotificationCenter  defaultCenter] removeObserver:self  name:@"ProveView" object:nil];
}
@end
