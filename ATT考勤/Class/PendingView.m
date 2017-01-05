//
//  PendingView.m
//  ATT考勤
//
//  Created by Helen on 16/12/28.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "PendingView.h"
#import "PendingViewModel.h"
#import "LogisticsView.h"

@interface PendingView()

@property(nonatomic,strong) PendingViewModel *pendingViewModel;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *number;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *department;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *type;

@property(nonatomic,strong) UILabel *reason;

@property(nonatomic,strong) UITextView *examine;

@property(nonatomic,strong) UIButton *disagree;

@property(nonatomic,strong) UIButton *agree;

@property(nonatomic,strong) LogisticsView *view;

@property(nonatomic,strong) UIButton *preBtn;

@property(nonatomic,strong) UILabel *page;

@property(nonatomic,strong) UIButton *lastBtn;

@end

@implementation PendingView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.pendingViewModel = (PendingViewModel *)viewModel;
    return [super initWithViewModel:self.pendingViewModel];
}


-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:15]);
    }];
    
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.title);
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:15]);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.number);
    }];
    
    [self.department mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-[self h_w:10]);
        make.top.equalTo(weakSelf.number);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.number);
        make.top.equalTo(weakSelf.number.mas_bottom).offset([self h_w:15]);
    }];
    
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.department);
        make.top.equalTo(weakSelf.time);
    }];
    
    [self.reason mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.time);
        make.top.equalTo(weakSelf.time.mas_bottom).offset([self h_w:15]);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [self.examine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.reason);
        make.top.equalTo(weakSelf.reason.mas_bottom).offset([self h_w:15]);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    
    [self.agree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.examine);
        make.top.equalTo(weakSelf.examine.mas_bottom).offset([self h_w:15]);
    }];
    
    [self.disagree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.agree.mas_left).offset(-[self h_w:10]);
        make.top.equalTo(weakSelf.agree);
    }];
    
    
    
    [self.preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset([self h_w:10]);
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
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.agree.mas_bottom).offset([self h_w:15]);
        make.left.equalTo([self h_w:10]);
        make.right.equalTo(-[self h_w:10]);
        make.bottom.equalTo(weakSelf.preBtn.mas_top).offset(-[self h_w:15]);
    }];
    
    
    [super updateConstraints];
}


#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.number];
    [self addSubview:self.name];
    [self addSubview:self.department];
    [self addSubview:self.time];
    [self addSubview:self.type];
    [self addSubview:self.reason];
    [self addSubview:self.examine];
    [self addSubview:self.disagree];
    [self addSubview:self.agree];
    [self addSubview:self.view];
    [self addSubview:self.preBtn];
    [self addSubview:self.page];
    [self addSubview:self.lastBtn];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    
    
}



#pragma mark lazyload
-(PendingViewModel *)pendingViewModel{
    if (!_pendingViewModel) {
        _pendingViewModel = [[PendingViewModel alloc] init];
    }
    return _pendingViewModel;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"申请类型:请假";
        _title.textColor = black_color;
        _title.font = H16;
    }
    return _title;
}



-(UILabel *)number{
    if (!_number) {
        _number = [[UILabel alloc] init];
        _number.text = @"工号:1001";
        _number.textColor = MAIN_PAN_2;
        _number.font = H14;
    }
    return _number;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"姓名:张飞";
        _name.textColor = MAIN_PAN_2;
        _name.font = H14;
    }
    return _name;
}

-(UILabel *)department{
    if (!_department) {
        _department = [[UILabel alloc] init];
        _department.text = @"部门:采购部门";
        _department.textColor = MAIN_PAN_2;
        _department.font = H14;
    }
    return _department;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"时长:2小时";
        _time.textColor = MAIN_PAN_2;
        _time.font = H14;
    }
    return _time;
}

-(UILabel *)type{
    if (!_type) {
        _type = [[UILabel alloc] init];
        _type.text = @"请假类型:事假";
        _type.textColor = MAIN_PAN_2;
        _type.font = H14;
    }
    return _type;
}

-(UILabel *)reason{
    if (!_reason) {
        _reason = [[UILabel alloc] init];
        _reason.text = @"请假原因:胃疼";
        _reason.textColor = MAIN_PAN_2;
        _reason.font = H14;
        //
    }
    return _reason;
}

-(UITextView *)examine{
    if (!_examine) {
        _examine = [[UITextView alloc] init];
        _examine.scrollEnabled = NO;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
        _examine.editable = YES;        //是否允许编辑内容，默认为“YES”
        //        _textView.delegate = self;       //设置代理方法的实现类
        _examine.font=[UIFont fontWithName:@"Arial" size:18.0]; //设置字体名字和字体大小;
        //        _textView.returnKeyType = UIReturnKeyDefault;//return键的类型
        //        _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _examine.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        _examine.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
        _examine.textColor = MAIN_PAN;
        _examine.text = @"审批意见";//设置显示的文本内容
        _examine.font = H14;
        _examine.layer.borderColor = LINE_COLOR.CGColor;
        _examine.layer.borderWidth =1.0;
        _examine.layer.cornerRadius =5.0;
    }
    return _examine;
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
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){242/255.f,130/255.f,74/255.f,1});
        
        [_disagree.layer setBorderColor:color];
    }
    return _disagree;
}

-(void)disagree:(UIButton *)button{
    
    
}

-(UIButton *)agree{
    if (!_agree) {
        _agree = [[UIButton alloc] init];
        
        [_agree setTitle:@"  同 意  " forState:UIControlStateNormal];
        _agree.titleLabel.font = H14;
        [_agree addTarget:self action:@selector(disagree:) forControlEvents:UIControlEventTouchUpInside];
        
        [_agree.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_agree.layer setCornerRadius:10];
        
        [_agree.layer setBorderWidth:2];//设置边界的宽度
        
        [_agree setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){242/255.f,130/255.f,74/255.f,1});
        
        [_agree.layer setBorderColor:color];
        
    }
    return _agree;
}

-(LogisticsView *)view{
    if (!_view) {
        _view = [[LogisticsView alloc] init];
        //        _view.backgroundColor = LINE_COLOR;
        _view.layer.borderColor = LINE_COLOR.CGColor;
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
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){242/255.f,130/255.f,74/255.f,1});
        
        [_preBtn.layer setBorderColor:color];
    }
    return _preBtn;
}

-(void)pre:(UIButton *)button{
    
    
}

-(UILabel *)page{
    if (!_page) {
        _page = [[UILabel alloc] init];
        _page.text = @"第1页/共3页";
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
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){242/255.f,130/255.f,74/255.f,1});
        
        [_lastBtn.layer setBorderColor:color];
    }
    return _lastBtn;
}

-(void)last:(UIButton *)button{
    
    
}

@end
