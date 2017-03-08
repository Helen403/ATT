//
//  MyOpinionView.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyOpinionView.h"
#import "MyOpinionViewModel.h"
#import "JSTextView.h"
#import "IQKeyboardManager.h"

@interface MyOpinionView()<UITextFieldDelegate>

@property(nonatomic,strong) MyOpinionViewModel *myOpinionViewModel;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *text1;

@property(nonatomic,strong) UILabel *text2;

@property(nonatomic,strong) UILabel *text3;

@property(nonatomic,strong) UILabel *text4;

@property(nonatomic,strong) UILabel *text5;

@property(nonatomic,strong) UILabel *text6;

@property(nonatomic,strong) UILabel *problem;

@property(nonatomic,strong) JSTextView *input;

@property(nonatomic,strong) UILabel *conn;

@property(nonatomic,strong) UITextField *phone;

@property(nonatomic,strong) UILabel *suggest;

@property(nonatomic,strong) UIButton *submit;

@end

@implementation MyOpinionView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.myOpinionViewModel = (MyOpinionViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    CGFloat height = [self h_w:25];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([self h_w:10]);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.title);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH-4*[self h_w:10])/3.f, height));
        
    }];
    
    [self.text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.text1);
        make.centerX.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH-4*[self h_w:10])/3.f, height));
    }];
    
    [self.text3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.text1);
        make.right.equalTo(-[self h_w:10]);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH-4*[self h_w:10])/3.f, height));
    }];
    
    [self.text4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.text1.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.text1);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH-4*[self h_w:10])/3.f, height));
    }];
    
    [self.text5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.text4);
        make.left.equalTo(weakSelf.text2);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH-4*[self h_w:10])/3.f, height));
    }];
    
    [self.text6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.text4);
        make.right.equalTo(weakSelf.text3);
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH-4*[self h_w:10])/3.f, height));
    }];
    
    [self.problem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.text4.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.text1);
    }];
    
    [self.input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.problem.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.text1);
        make.right.equalTo(weakSelf.text3);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:120]));
    }];
    
    [self.conn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.input.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.text1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:40]));
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.conn.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.text1);
        make.right.equalTo(weakSelf.text3);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:40]));
    }];
    
    [self.suggest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phone.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.text1);
        make.right.equalTo(weakSelf.text3);
    }];
    
    [self.submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggest.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.text1);
        make.right.equalTo(weakSelf.text3);
    }];
    
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.text1];
    [self addSubview:self.text2];
    [self addSubview:self.text3];
    [self addSubview:self.text4];
    [self addSubview:self.text5];
    [self addSubview:self.text6];
    [self addSubview:self.problem];
    [self addSubview:self.input];
    [self addSubview:self.conn];
    [self addSubview:self.phone];
    [self addSubview:self.suggest];
    [self addSubview:self.submit];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

}

-(void)h_bindViewModel{
    
}


-(void)h_viewWillAppear{
    //打开键盘事件相应
    [IQKeyboardManager sharedManager].enable = NO;
}

-(void)h_viewWillDisappear{
    //关闭键盘事件相应
    [IQKeyboardManager sharedManager].enable = YES;
}


#pragma mark lazyload
-(MyOpinionViewModel *)myOpinionViewModel{
    if (!_myOpinionViewModel) {
        _myOpinionViewModel = [[MyOpinionViewModel alloc] init];
    }
    return _myOpinionViewModel;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"反馈类型";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UILabel *)text1{
    if (!_text1) {
        _text1 = [[UILabel alloc] init];
        _text1.text = @"  登陆，注册  ";
        _text1.font = H14;
        _text1.textColor = MAIN_PAN_2;
        _text1.textAlignment = NSTextAlignmentCenter;
        ViewBorderRadius(_text1, 5, 1, MAIN_LINE_COLOR);
    }
    return _text1;
}

-(UILabel *)text2{
    if (!_text2) {
        _text2 = [[UILabel alloc] init];
        _text2.text = @"  账户，积分  ";
        _text2.font = H14;
        _text2.textColor = MAIN_PAN_2;
        _text2.textAlignment = NSTextAlignmentCenter;
        ViewBorderRadius(_text2, 5, 1, MAIN_LINE_COLOR);
    }
    return _text2;
}

-(UILabel *)text3{
    if (!_text3) {
        _text3 = [[UILabel alloc] init];
        _text3.text = @"  打卡，提醒  ";
        _text3.font = H14;
        _text3.textColor = MAIN_PAN_2;
        _text3.textAlignment = NSTextAlignmentCenter;
        ViewBorderRadius(_text3, 5, 1, MAIN_LINE_COLOR);
    }
    return _text3;
}

-(UILabel *)text4{
    if (!_text4) {
        _text4 = [[UILabel alloc] init];
        _text4.text = @"  申请，审批  ";
        _text4.font = H14;
        _text4.textColor = MAIN_PAN_2;
        _text4.textAlignment = NSTextAlignmentCenter;
        ViewBorderRadius(_text4, 5, 1, MAIN_LINE_COLOR);
    }
    return _text4;
}

-(UILabel *)text5{
    if (!_text5) {
        _text5 = [[UILabel alloc] init];
        _text5.text = @"  统计，报表  ";
        _text5.font = H14;
        _text5.textColor = MAIN_PAN_2;
        _text5.textAlignment = NSTextAlignmentCenter;
        ViewBorderRadius(_text5, 5, 1, MAIN_LINE_COLOR);
    }
    return _text5;
}

-(UILabel *)text6{
    if (!_text6) {
        _text6 = [[UILabel alloc] init];
        _text6.text = @"  消息，公告  ";
        _text6.font = H14;
        _text6.textColor = MAIN_PAN_2;
        _text6.textAlignment = NSTextAlignmentCenter;
        ViewBorderRadius(_text6, 5, 1, MAIN_LINE_COLOR);
    }
    return _text6;
}

-(UILabel *)problem{
    if (!_problem) {
        _problem = [[UILabel alloc] init];
        _problem.text = @"请你描述您遇到的问题(不少于10个字)";
        _problem.font = H14;
        _problem.textColor = MAIN_PAN_2;
    }
    return _problem;
}

-(JSTextView *)input{
    if (!_input) {
        _input = [[JSTextView alloc] init];
        _input.scrollEnabled = NO;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
        _input.editable = YES;        //是否允许编辑内容，默认为“YES”
        //        _textView.delegate = self;       //设置代理方法的实现类
        _input.font=[UIFont fontWithName:@"Arial" size:18.0]; //设置字体名字和字体大小;
        //        _textView.returnKeyType = UIReturnKeyDefault;//return键的类型
        //        _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _input.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        _input.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
        _input.textColor = MAIN_PAN_2;
        //        _input.text = @"";//设置显示的文本内容
        
        _input.myPlaceholder=@"我遇到的问题是(如有需要,我们会与你留的联系方式和你取得联系,做意见的反馈)";
        
        //2.设置提醒文字颜色
        
        _input.myPlaceholderColor= [UIColor lightGrayColor];
        _input.layer.borderColor = MAIN_LINE_COLOR.CGColor;
        _input.layer.borderWidth =1.0;
        _input.layer.cornerRadius =5.0;
        _input.font = H14;
        
        //_input.delegate = self;
        
    }
    return _input;
}

-(UILabel *)conn{
    if (!_conn) {
        _conn = [[UILabel alloc] init];
        _conn.text = @"你的联系方式(选填)";
        _conn.font = H14;
        _conn.textColor = MAIN_PAN_2;
    }
    return _conn;
}

-(UITextField *)phone{
    if (!_phone) {
        _phone = [[UITextField alloc] init];
        
        _phone.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _phone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //当输入框没有内容时，水印提示 提示内容为password
        _phone.placeholder = @" 手机号/邮箱/QQ号/微信号填其中一个即可";
        
        //修改account的placeholder的字体颜色、大小
        [_phone setValue: MAIN_TEXTFIELD forKeyPath:@"_placeholderLabel.textColor"];
        [_phone setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _phone.font = H14;
        // 设置右边永远显示清除按钮
        _phone.clearButtonMode = UITextFieldViewModeAlways;
        ViewBorderRadius(_phone, 5, 1, MAIN_LINE_COLOR);
        _phone.delegate = self;
        
    }
    return _phone;
}

-(void)textFieldDidBeginEditing:(UITextField *)textView{

    [UIView animateWithDuration:0.25 animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:7];
        self.transform = CGAffineTransformMakeTranslation(0, -258.00000f);
    }];
    
    
}

//完成编辑的时候下移回来（只要把offset重新设为0就行了）

-(void)textFieldDidEndEditing:(UITextField *)textView{

    [UIView animateWithDuration:0.25 animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:7];
        self.transform = CGAffineTransformIdentity;
    }];
    
}

-(UILabel *)suggest{
    if (!_suggest) {
        _suggest = [[UILabel alloc] init];
        _suggest.text = @"非常感谢您对本产品提出宝贵的意见，有了您的大力支持产品才能够更完善";
        //        _suggest.lineBreakMode = UILineBreakModeWordWrap;
        [_suggest setLineBreakMode:NSLineBreakByWordWrapping];
        _suggest.numberOfLines = 0;
        _suggest.font = H14;
        _suggest.textColor = MAIN_PAN_2;
    }
    return _suggest;
    
}

-(UIButton *)submit{
    if (!_submit) {
        _submit = [[UIButton alloc] init];
        
        [_submit setTitle:@"提   交" forState:UIControlStateNormal];
        _submit.titleLabel.font = H22;
        [_submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        
        [_submit.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_submit.layer setCornerRadius:10];
        
        [_submit.layer setBorderWidth:2];//设置边界的宽度
        
        [_submit setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        
        [_submit.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    return _submit;
}

-(void)submit:(UIButton *)button{
    
    
    
}

@end
