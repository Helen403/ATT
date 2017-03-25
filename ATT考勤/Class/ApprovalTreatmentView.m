//
//  ApprovalTreatmentView.m
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ApprovalTreatmentView.h"
#import "ApprovalTreatmentViewModel.h"

#import "LogisticsView.h"
#import "LateTreatmentModel.h"
#import "JSTextView.h"
#import "UserModel.h"

@interface ApprovalTreatmentView()

@property(nonatomic,strong) ApprovalTreatmentViewModel *approvalTreatmentViewModel;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *startTime;

@property(nonatomic,strong) UILabel *endTime;

@property(nonatomic,strong) UILabel *witness;

@property(nonatomic,strong) UILabel *reasonExplain;

@property(nonatomic,strong) UILabel *reason;

@property(nonatomic,strong) UILabel *examine;

@property(nonatomic,strong) UIButton *disagree;

@property(nonatomic,strong) UIButton *agree;

@property(nonatomic,strong) LogisticsView *view;

@property(nonatomic,strong) UIButton *preBtn;

@property(nonatomic,strong) UILabel *page;

@property(nonatomic,strong) UIButton *lastBtn;

@property(nonatomic,strong) JSTextView *examineTextView;

@property(nonatomic,strong) UILabel *compensate;

@end


@implementation ApprovalTreatmentView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.approvalTreatmentViewModel = (ApprovalTreatmentViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:15]);
    }];
    
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf).offset([self h_w:40]);
        make.top.equalTo(weakSelf.title);
    }];
    
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.name);
        make.top.equalTo(weakSelf.startTime);
    }];
    
    [self.witness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.title);
        make.top.equalTo(weakSelf.startTime.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.compensate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.name);
        make.top.equalTo(weakSelf.witness);
    }];
    
    [self.reasonExplain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.title);
        make.top.equalTo(weakSelf.witness.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.reason mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.reasonExplain.mas_bottom).offset([self h_w:10]) ;
        make.left.equalTo(weakSelf.title);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [self.examine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.reasonExplain);
        make.top.equalTo(weakSelf.reasonExplain.mas_bottom).offset([self h_w:35]);
        
    }];
    
    [self.examineTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.examine.mas_bottom).offset([self h_w:10]);
        make.centerX.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-[self h_w:20], [self h_w:60]));
    }];
    
    
    [self.agree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.examineTextView);
        make.top.equalTo(weakSelf.examineTextView.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.disagree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.agree.mas_left).offset(-[self h_w:10]);
        make.top.equalTo(weakSelf.agree);
    }];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.agree.mas_bottom).offset([self h_w:10]);
        make.centerX.equalTo(weakSelf);;
        
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-[self h_w:20], [self h_w:220]));
    }];
    
    
    [self.preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf).offset([self h_w:10]);
    }];
    
    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.preBtn);
    }];
    
    [self.lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.preBtn);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.name];
    [self addSubview:self.startTime];
    [self addSubview:self.endTime];
    [self addSubview:self.witness];
    [self addSubview:self.compensate];
    [self addSubview:self.reasonExplain];
    [self addSubview:self.reason];
    [self addSubview:self.examine];
    [self addSubview:self.examineTextView];
    [self addSubview:self.disagree];
    [self addSubview:self.agree];
    [self addSubview:self.view];
    [self addSubview:self.preBtn];
    [self addSubview:self.page];
    [self addSubview:self.lastBtn];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


#pragma mark dataload
-(void)refreash:(NSInteger)indexTmp{
    ShowMaskStatus(@"正在拼命加载");
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.approvalTreatmentViewModel.companyCode = companyCode;
    self.approvalTreatmentViewModel.indexTmp = indexTmp;
    [self.approvalTreatmentViewModel.refreshDataCommand execute:nil];
}

-(void)h_bindViewModel{
    
    [[self.approvalTreatmentViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            LateTreatmentModel * lateTreatment = self.approvalTreatmentViewModel.lateArr[self.indexTmp];
            
            NSString *apType = lateTreatment.applyType;
            self.title.text = [NSString stringWithFormat:@"类型:%@",apType];
            self.name.text = [NSString stringWithFormat:@"姓名:%@",self.approvalTreatmentViewModel.approvalTreament.userName];
            
            
            if ([@"请假" isEqualToString:apType]) {
                //=================================================
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"请假类型:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"时长:%@",self.approvalTreatmentViewModel.approvalTreament.type2Name];
                
                // =================================================
            }
            if ([@"加班" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"加班类型:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"补偿类型:%@",self.approvalTreatmentViewModel.approvalTreament.type2Name];
                // =================================================
            }
            if ([@"出差" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"出差地点:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"费用类型:%@",self.approvalTreatmentViewModel.approvalTreament.type2Name];
                // =================================================
            }
            if ([@"外出" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"外出地点:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"外出类型:%@",self.approvalTreatmentViewModel.approvalTreament.type2Name];
                // =================================================
            }
            if ([@"换班" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"原来班次:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"新的班次:%@",self.approvalTreatmentViewModel.approvalTreament.type2Name];
                // =================================================
            }
            if ([@"调班" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"原来班次:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"新的班次:%@",self.approvalTreatmentViewModel.approvalTreament.type2Name];
                // =================================================
            }
            if ([@"辞职" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"申请时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"计划离岗:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"辞职形式:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                  self.compensate.text = @"";
                // =================================================
            }
            if ([@"调休" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"调休类别:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                self.compensate.text = @"";
                // =================================================
            }
            if ([@"漏打卡" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"漏打时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"补打时间:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"证明人:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                self.compensate.text = @"";
                // =================================================
            }
            if ([@"消迟到" isEqualToString:apType]) {
                // =================================================
                
                
                self.startTime.text=[NSString stringWithFormat:@"迟到时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"正常时间:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"证明人:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                self.compensate.text = @"";
                // =================================================
            }
            if ([@"消早退" isEqualToString:apType]) {
                // =================================================
                
                
                self.startTime.text=[NSString stringWithFormat:@"早退时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"正常时间:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"证明人:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                self.compensate.text = @"";
                // =================================================
            }
            if ([@"报销" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"申请时间:%@",self.approvalTreatmentViewModel.approvalTreament.startDate];
                self.endTime.text = [NSString stringWithFormat:@"报销部门:%@",self.approvalTreatmentViewModel.approvalTreament.endDate];
                self.witness.text = [NSString stringWithFormat:@"费用类别:%@",self.approvalTreatmentViewModel.approvalTreament.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"报销金额:%@",self.approvalTreatmentViewModel.approvalTreament.type2Name];
                // =================================================
            }
            
            self.reason.text = self.approvalTreatmentViewModel.approvalTreament.reason;
            self.page.text = [NSString stringWithFormat:@"第%ld页/共%lu页",(long)self.indexTmp+1,(unsigned long)self.approvalTreatmentViewModel.lateArr.count];
            
            self.view.arr = self.approvalTreatmentViewModel.arr;
        });
        
    }];
}


#pragma mark lazyload
-(ApprovalTreatmentViewModel *)approvalTreatmentViewModel{
    if (!_approvalTreatmentViewModel) {
        _approvalTreatmentViewModel = [[ApprovalTreatmentViewModel alloc] init];
    }
    return _approvalTreatmentViewModel;
}


-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"类型:";
        _title.textColor = black_color;
        _title.font = H14;
    }
    return _title;
}



-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"姓名:";
        _name.textColor = MAIN_PAN_2;
        _name.font = H14;
    }
    return _name;
}

-(UILabel *)startTime{
    if (!_startTime) {
        _startTime = [[UILabel alloc] init];
        _startTime.text = @"";
        _startTime.textColor = MAIN_PAN_2;
        _startTime.font = H14;
    }
    return _startTime;
}

-(UILabel *)endTime{
    if (!_endTime) {
        _endTime = [[UILabel alloc] init];
        _endTime.text = @"";
        _endTime.textColor = MAIN_PAN_2;
        _endTime.font = H14;
    }
    return _endTime;
}

-(UILabel *)witness{
    if (!_witness) {
        _witness = [[UILabel alloc] init];
        _witness.text = @"";
        _witness.textColor = MAIN_PAN_2;
        _witness.font = H14;
    }
    return _witness;
}

-(UILabel *)reason{
    if (!_reason) {
        _reason = [[UILabel alloc] init];
        _reason.text = @"";
        _reason.textColor = MAIN_PAN_2;
        _reason.font = H14;
    }
    return _reason;
}

-(UILabel *)reasonExplain{
    if (!_reasonExplain) {
        _reasonExplain = [[UILabel alloc] init];
        _reasonExplain.text = @"原因和理由:";
        _reasonExplain.textColor = MAIN_PAN_2;
        _reasonExplain.font = H14;
    }
    return _reasonExplain;
}

-(UILabel *)examine{
    if (!_examine) {
        _examine = [[UILabel alloc] init];
        _examine.text = @"审批意见:";
        _examine.font = H14;
        _examine.textColor = MAIN_PAN_2;
    }
    return _examine;
}

-(UILabel *)compensate{
    if (!_compensate) {
        _compensate = [[UILabel alloc] init];
        _compensate.text = @"";
        _compensate.font = H14;
        _compensate.textColor = MAIN_PAN_2;
    }
    return _compensate;
}


-(JSTextView *)examineTextView{
    if (!_examineTextView) {
        _examineTextView  = [[JSTextView alloc] init];
        //        _textView.backgroundColor = yellow_color;
        
        _examineTextView.scrollEnabled = NO;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
        _examineTextView.editable = YES;        //是否允许编辑内容，默认为“YES”
        //        _textView.delegate = self;       //设置代理方法的实现类
        _examineTextView.font=[UIFont fontWithName:@"Arial" size:18.0]; //设置字体名字和字体大小;
        //        _textView.returnKeyType = UIReturnKeyDefault;//return键的类型
        //        _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _examineTextView.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        _examineTextView.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
        _examineTextView.textColor = MAIN_PAN_2;
        
        _examineTextView.myPlaceholder = @"输入审批意见";//设置显示的文本内容
        
        _examineTextView.myPlaceholderColor= [UIColor lightGrayColor];
        //2.设置提醒文字颜色
        
        _examineTextView.layer.borderColor = MAIN_LINE_COLOR.CGColor;
        _examineTextView.layer.borderWidth =1.0;
        _examineTextView.layer.cornerRadius =5.0;
        _examineTextView.font = H14;
        
    }
    return _examineTextView;
}


-(UIButton *)disagree{
    if (!_disagree) {
        _disagree = [[UIButton alloc] init];
        
        [_disagree setTitle:@"  不同意  " forState:UIControlStateNormal];
        _disagree.titleLabel.font = H14;
        [_disagree addTarget:self action:@selector(disagree:) forControlEvents:UIControlEventTouchUpInside];
        
        [_disagree.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_disagree.layer setCornerRadius:10];
        
        [_disagree.layer setBorderWidth:2];//设置边界的宽度
        
        [_disagree setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色

        [_disagree.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    return _disagree;
}

-(void)disagree:(UIButton *)button{
//    if (self.examineTextView.text.length == 0) {
//        ShowMessage(@"请入审批意见");
//        return;
//    }
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.approvalTreatmentViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.approvalTreatmentViewModel.userCode = user.userCode;
    LateTreatmentModel * lateTreatment = self.approvalTreatmentViewModel.lateArr[self.indexTmp];

    self.approvalTreatmentViewModel.applyType = lateTreatment.applyType;
    
    self.approvalTreatmentViewModel.applyLsh = lateTreatment.applyLsh;
    self.approvalTreatmentViewModel.stepCheckStatus = @"1";
    self.approvalTreatmentViewModel.stepCheckMsg = self.examineTextView.text;
    [self.approvalTreatmentViewModel.updateCheckFlowCommand execute:nil];
    [self last];
    
}

-(void)agree:(UIButton *)button{
//    if (self.examineTextView.text.length == 0) {
//        ShowMessage(@"请入审批意见");
//        return;
//    }
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.approvalTreatmentViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.approvalTreatmentViewModel.userCode = user.userCode;
    LateTreatmentModel * lateTreatment = self.approvalTreatmentViewModel.lateArr[self.indexTmp];
    
    self.approvalTreatmentViewModel.applyType = lateTreatment.applyType;
    
    self.approvalTreatmentViewModel.applyLsh = lateTreatment.applyLsh;
    self.approvalTreatmentViewModel.stepCheckStatus = @"0";
    self.approvalTreatmentViewModel.stepCheckMsg = self.examineTextView.text;
    [self.approvalTreatmentViewModel.updateCheckFlowCommand execute:nil];
    [self last];
    
}


-(UIButton *)agree{
    if (!_agree) {
        _agree = [[UIButton alloc] init];
        
        [_agree setTitle:@"  同 意  " forState:UIControlStateNormal];
        _agree.titleLabel.font = H14;
        [_agree addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
        
        [_agree.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_agree.layer setCornerRadius:10];
        
        [_agree.layer setBorderWidth:2];//设置边界的宽度
        
        [_agree setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        
        [_agree.layer setBorderColor:MAIN_ORANGER.CGColor];
        
    }
    return _agree;
}

-(LogisticsView *)view{
    if (!_view) {
        _view = [[LogisticsView alloc] init];
        _view.layer.borderColor = MAIN_LINE_COLOR.CGColor;
        _view.layer.borderWidth =1.0;
        _view.layer.cornerRadius =5.0;
    }
    return _view;
}

-(UIButton *)preBtn{
    if (!_preBtn) {
        _preBtn =[[UIButton alloc] init];
        
        [_preBtn setTitle:@"  上一页  " forState:UIControlStateNormal];
        _preBtn.titleLabel.font = H14;
        [_preBtn addTarget:self action:@selector(pre) forControlEvents:UIControlEventTouchUpInside];
        
        [_preBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_preBtn.layer setCornerRadius:10];
        
        [_preBtn.layer setBorderWidth:2];//设置边界的宽度
        
        [_preBtn setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        
        
        [_preBtn.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    return _preBtn;
}



-(UILabel *)page{
    if (!_page) {
        _page = [[UILabel alloc] init];
        _page.text = @"";
        _page.textColor = black_color;
        _page.font = H14;
    }
    return _page;
}

-(UIButton *)lastBtn{
    if (!_lastBtn) {
        _lastBtn = [[UIButton alloc] init];
        
        [_lastBtn setTitle:@"  下一页  " forState:UIControlStateNormal];
        _lastBtn.titleLabel.font = H14;
        [_lastBtn addTarget:self action:@selector(last) forControlEvents:UIControlEventTouchUpInside];
        
        [_lastBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_lastBtn.layer setCornerRadius:10];
        
        [_lastBtn.layer setBorderWidth:2];//设置边界的宽度
        
        [_lastBtn setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        
        
        [_lastBtn.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    return _lastBtn;
}

-(void)pre{
    --self.indexTmp;
    if (self.indexTmp<0) {
        self.indexTmp=0;
    }
    self.examineTextView.text = @"";
    [self refreash:self.indexTmp];
}

-(void)last{
    ++self.indexTmp;
    if (self.indexTmp==self.approvalTreatmentViewModel.lateArr.count) {
        self.indexTmp=self.approvalTreatmentViewModel.lateArr.count-1;
    }
    self.examineTextView.text = @"";
    [self refreash:self.indexTmp];
}

@end
