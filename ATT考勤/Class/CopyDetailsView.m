//
//  CopyDetailsView.m
//  ATT考勤
//
//  Created by Helen on 17/3/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CopyDetailsView.h"


#import "CopyDetailsViewModel.h"
#import "LogisticsView.h"
#import "UserModel.h"
#import "CopyToMeModel.h"


@interface CopyDetailsView()

@property(nonatomic,strong) CopyDetailsViewModel *copyDetailsViewModel;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *startTime;

@property(nonatomic,strong) UILabel *endTime;

@property(nonatomic,strong) UILabel *witness;

@property(nonatomic,strong) UILabel *reasonExplain;

@property(nonatomic,strong) UILabel *reason;

@property(nonatomic,strong) LogisticsView *view;

@property(nonatomic,strong) UIButton *preBtn;

@property(nonatomic,strong) UILabel *page;

@property(nonatomic,strong) UIButton *lastBtn;

@property(nonatomic,strong) UILabel *compensate;

@property(nonatomic,strong) UIView *bgView;

@end


@implementation CopyDetailsView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.copyDetailsViewModel = (CopyDetailsViewModel *)viewModel;
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
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.reasonExplain.mas_bottom).offset([self h_w:10]) ;
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-[self h_w:20], [self h_w:130]));
        make.centerX.equalTo(weakSelf);;
    }];
    
    [self.reason mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView.mas_top).offset([self h_w:10]) ;
        make.left.equalTo(weakSelf.bgView.mas_left).offset([self h_w:10]);
        make.right.equalTo(weakSelf.bgView.mas_right).offset(-[self h_w:10]);
    }];
    
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView.mas_bottom).offset([self h_w:10]);
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
    [self addSubview:self.bgView];
    [self addSubview:self.compensate];
    [self addSubview:self.reasonExplain];
    [self addSubview:self.reason];
    
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
    self.copyDetailsViewModel.companyCode = companyCode;
    self.copyDetailsViewModel.indexTmp = indexTmp;
    self.indexTmp = indexTmp;
    [self.copyDetailsViewModel.refreshDataCommand execute:nil];
}

-(void)h_bindViewModel{
    
    [[self.copyDetailsViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            CopyToMeModel * lateTreatment = self.copyDetailsViewModel.lateArr[self.indexTmp];
            
            NSString *apType = lateTreatment.applyType;
            self.title.text = [NSString stringWithFormat:@"类型:%@",apType];
            self.name.text = [NSString stringWithFormat:@"姓名:%@",self.copyDetailsViewModel.toDetailModel.userName];
            
            
            if ([@"请假" isEqualToString:apType]) {
                //=================================================
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                self.witness.text = [NSString stringWithFormat:@"请假类型:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"时长:%.f小时",self.copyDetailsViewModel.toDetailModel.type2Name.floatValue/60.0f];
                
                // =================================================
            }
            if ([@"加班" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                self.witness.text = [NSString stringWithFormat:@"加班类型:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"补偿类型:%@",self.copyDetailsViewModel.toDetailModel.type2Name];
                // =================================================
            }
            if ([@"出差" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                self.witness.text = [NSString stringWithFormat:@"出差地点:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"费用类型:%@",self.copyDetailsViewModel.toDetailModel.type2Name];
                // =================================================
            }
            if ([@"外出" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                self.witness.text = [NSString stringWithFormat:@"外出地点:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"外出类型:%@",self.copyDetailsViewModel.toDetailModel.type2Name];
                // =================================================
            }
            if ([@"换班" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                self.witness.text = [NSString stringWithFormat:@"原来班次:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"新的班次:%@",self.copyDetailsViewModel.toDetailModel.type2Name];
                // =================================================
            }
            if ([@"调班" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                self.witness.text = [NSString stringWithFormat:@"原来班次:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"新的班次:%@",self.copyDetailsViewModel.toDetailModel.type2Name];
                // =================================================
            }
            if ([@"辞职" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"申请时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"计划离岗:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                self.witness.text = [NSString stringWithFormat:@"辞职形式:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                self.compensate.text = @"";
                // =================================================
            }
            if ([@"调休" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"开始时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"结束时间:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                self.witness.text = [NSString stringWithFormat:@"调休类别:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                self.compensate.text = @"";
                // =================================================
            }
            if ([@"漏打卡" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"漏打时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"补打时间:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                if (self.copyDetailsViewModel.toDetailModel.type1Name==nil) {
                    self.witness.text = @"证明人:";
                }else{
                    self.witness.text = [NSString stringWithFormat:@"证明人:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                }
                self.compensate.text = @"";
                // =================================================
            }
            if ([@"消迟到" isEqualToString:apType]) {
                // =================================================
                
                
                self.startTime.text=[NSString stringWithFormat:@"迟到时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"正常时间:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                if (self.copyDetailsViewModel.toDetailModel.type1Name==nil) {
                    self.witness.text = @"证明人:";
                }else{
                    self.witness.text = [NSString stringWithFormat:@"证明人:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                }
                self.compensate.text = @"";
                // =================================================
            }
            if ([@"消早退" isEqualToString:apType]) {
                // =================================================
                
                
                self.startTime.text=[NSString stringWithFormat:@"早退时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"正常时间:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                
                if (self.copyDetailsViewModel.toDetailModel.type1Name==nil) {
                    self.witness.text = @"证明人:";
                }else{
                    self.witness.text = [NSString stringWithFormat:@"证明人:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                }
                self.compensate.text = @"";
                // =================================================
            }
            if ([@"报销" isEqualToString:apType]) {
                // =================================================
                
                self.startTime.text=[NSString stringWithFormat:@"申请时间:%@",self.copyDetailsViewModel.toDetailModel.startDate];
                self.endTime.text = [NSString stringWithFormat:@"报销部门:%@",self.copyDetailsViewModel.toDetailModel.endDate];
                self.witness.text = [NSString stringWithFormat:@"费用类别:%@",self.copyDetailsViewModel.toDetailModel.type1Name];
                self.compensate.text = [NSString stringWithFormat:@"报销金额:%@",self.copyDetailsViewModel.toDetailModel.type2Name];
                // =================================================
            }
            
            self.reason.text = self.copyDetailsViewModel.toDetailModel.reason;
            self.page.text = [NSString stringWithFormat:@"第%ld页/共%lu页",(long)self.indexTmp+1,(unsigned long)self.copyDetailsViewModel.lateArr.count];
            
            self.view.arr = self.copyDetailsViewModel.arr;
        });
        
    }];
}


#pragma mark lazyload
-(CopyDetailsViewModel *)copyDetailsViewModel{
    if (!_copyDetailsViewModel) {
        _copyDetailsViewModel = [[CopyDetailsViewModel alloc] init];
    }
    return _copyDetailsViewModel;
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



-(UILabel *)compensate{
    if (!_compensate) {
        _compensate = [[UILabel alloc] init];
        _compensate.text = @"";
        _compensate.font = H14;
        _compensate.textColor = MAIN_PAN_2;
    }
    return _compensate;
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
        [_preBtn addTarget:self action:@selector(pre:) forControlEvents:UIControlEventTouchUpInside];
        [_preBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [_preBtn.layer setCornerRadius:10];
        [_preBtn.layer setBorderWidth:2];//设置边界的宽度
        [_preBtn setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        [_preBtn.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    return _preBtn;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.borderColor = MAIN_LINE_COLOR.CGColor;
        _bgView.layer.borderWidth =1.0;
        _bgView.layer.cornerRadius =5.0;
    }
    return _bgView;
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
        [_lastBtn addTarget:self action:@selector(last:) forControlEvents:UIControlEventTouchUpInside];
        [_lastBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [_lastBtn.layer setCornerRadius:10];
        [_lastBtn.layer setBorderWidth:2];//设置边界的宽度
        [_lastBtn setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        [_lastBtn.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    return _lastBtn;
}

-(void)pre:(UIButton *)button{
    --self.indexTmp;
    if (self.indexTmp<0) {
        self.indexTmp=0;
    }
    
    [self refreash:self.indexTmp];
}

-(void)last:(UIButton *)button{
    ++self.indexTmp;
    if (self.indexTmp==self.copyDetailsViewModel.lateArr.count) {
        self.indexTmp=self.copyDetailsViewModel.lateArr.count-1;
    }
    
    [self refreash:self.indexTmp];
}

@end
