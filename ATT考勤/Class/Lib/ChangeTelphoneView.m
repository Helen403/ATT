//
//  ChangeTelphoneView.m
//  ATT考勤
//
//  Created by Helen on 17/2/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChangeTelphoneView.h"
#import "ChangeTelphoneViewModel.h"
#import "UserModel.h"

@interface ChangeTelphoneView()

@property(nonatomic,strong) ChangeTelphoneViewModel *changeTelphoneViewModel;

@property(nonatomic,strong) UIImageView *useImg;

@property(nonatomic,strong) UILabel *useLabel;

@property(nonatomic,strong) UILabel *useText;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIImageView *telphoneImg;

@property(nonatomic,strong) UILabel *telphoneLabel;

@property(nonatomic,strong) UITextField *telphoneText;

@property(nonatomic,strong) UIButton *countDown;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIImageView *validateImg;

@property(nonatomic,strong) UILabel *validateLabel;

@property(nonatomic,strong) UITextField *validateText;

@property(nonatomic,strong) UIView *line3;

@property(nonatomic,strong) UIButton *next;

@property(nonatomic,strong) NSString *backNumber;

@end

@implementation ChangeTelphoneView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.changeTelphoneViewModel = (ChangeTelphoneViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    
    CGFloat leftPadding =(SCREEN_WIDTH-SCREEN_WIDTH*0.8)*0.5;
    CGFloat topPadding = SCREEN_HEIGHT *0.05;
    CGFloat length = SCREEN_WIDTH-SCREEN_WIDTH*0.35;
    
    [self.useImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topPadding);
        make.left.equalTo(leftPadding);
    }];
    
    [self.useLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.useImg);
        make.left.equalTo(weakSelf.useImg.mas_right).offset([self h_w:10]);
    }];
    
    [self.useText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.useImg);
        make.left.equalTo(weakSelf.useLabel.mas_right).offset([self h_w:10]);
        make.size.equalTo(CGSizeMake(length, [self h_w:30]));
    }];
    
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding*2,[self h_w:1]));
        make.right.equalTo(-leftPadding);
        make.top.equalTo(weakSelf.useText.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.telphoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1.mas_bottom).offset([self h_w:15]);
        make.left.equalTo(weakSelf.useImg);
    }];
    
    [self.telphoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.telphoneImg);
        make.left.equalTo(weakSelf.useLabel);
    }];
    [self.telphoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.telphoneImg);
        make.left.equalTo(weakSelf.useText);
        make.size.equalTo(CGSizeMake(length, [self h_w:30]));
    }];
    
    [self.countDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.telphoneImg);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake([self h_w:70], [self h_w:32]));
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding*2,[self h_w:1]));
        make.right.equalTo(-leftPadding);
        make.top.equalTo(weakSelf.telphoneImg.mas_bottom).offset([self h_w:10]);
    }];
    
    [self.validateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.useImg);
        make.top.equalTo(weakSelf.line2.mas_bottom).offset([self h_w:15]);
    }];
    
    [self.validateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.validateImg);
        make.left.equalTo(weakSelf.useLabel);
    }];
    
    [self.validateText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.validateImg);
        make.left.equalTo(weakSelf.useText);
        make.size.equalTo(CGSizeMake([self h_w:100], [self h_w:30]));
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.validateImg.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
    }];
    
    [self.next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line3.mas_bottom).offset([self h_w:15]);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.useImg];
    [self addSubview:self.useLabel];
    [self addSubview:self.useText];
    [self addSubview:self.line1];
    [self addSubview:self.telphoneImg];
    [self addSubview:self.telphoneLabel];
    [self addSubview:self.telphoneText];
    [self addSubview:self.countDown];
    [self addSubview:self.line2];
    
    [self addSubview:self.validateImg];
    [self addSubview:self.validateLabel];
    [self addSubview:self.validateText];
    [self addSubview:self.line3];
    [self addSubview:self.next];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    //请求返回回来的验证码
    [[self.changeTelphoneViewModel.SMSbackSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *x) {
       
        self.backNumber = x;
        
    }];
    
    //手机号不符合
    [[self.changeTelphoneViewModel.telphoneBackFailSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
    }];
    
}

-(void)mainThread{
    self.telphoneText.text = @"";
}



-(void)h_loadData{
    NSString *empTelphone =  [[NSUserDefaults standardUserDefaults] objectForKey:@"empTelphone"];
    self.useText.text = empTelphone;
}


#pragma mark lazyload
-(ChangeTelphoneViewModel *)changeTelphoneViewModel{
    if (!_changeTelphoneViewModel) {
        _changeTelphoneViewModel = [[ChangeTelphoneViewModel alloc] init];
    }
    return _changeTelphoneViewModel;
}

-(UIImageView *)useImg{
    if (!_useImg) {
        _useImg = [[UIImageView alloc] init];
        _useImg.image = ImageNamed(@"login_phone_picture");
    }
    return _useImg;
}

-(UILabel *)useLabel{
    if (!_useLabel) {
        _useLabel = [[UILabel alloc] init];
        _useLabel.text = @"原来手机号";
        _useLabel.textColor = MAIN_PAN_2;
        _useLabel.font = H14;
    }
    return _useLabel;
}

-(UILabel *)useText{
    if (!_useText) {
        _useText = [[UILabel alloc] init];
        _useText.text = @"";
        _useText.textColor = MAIN_PAN_2;
        _useText.font = H14;
    }
    return _useText;
}

-(UIImageView *)telphoneImg{
    if (!_telphoneImg) {
        _telphoneImg = [[UIImageView alloc] init];
        _telphoneImg.image = ImageNamed(@"login_phone_picture");
    }
    return _telphoneImg;
}

-(UILabel *)telphoneLabel{
    if (!_telphoneLabel) {
        _telphoneLabel = [[UILabel alloc] init];
        _telphoneLabel.text = @"新的手机号";
        _telphoneLabel.textColor = MAIN_PAN_2;
        _telphoneLabel.font = H14;
    }
    return _telphoneLabel;
}

-(UILabel *)validateLabel{
    if (!_validateLabel) {
        _validateLabel = [[UILabel alloc] init];
        _validateLabel.text = @"输入验证码";
        _validateLabel.textColor = MAIN_PAN_2;
        _validateLabel.font = H14;
    }
    return _validateLabel;
}

-(UITextField *)telphoneText{
    if (!_telphoneText) {
        _telphoneText = [[UITextField alloc] init];
        
        _telphoneText.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _telphoneText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

        //当输入框没有内容时，水印提示 提示内容为password
        _telphoneText.placeholder = @"输入手机号";
        
        //修改account的placeholder的字体颜色、大小
        [_telphoneText setValue: MAIN_TEXTFIELD forKeyPath:@"_placeholderLabel.textColor"];
        [_telphoneText setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _telphoneText.font = H14;
        // 设置右边永远显示清除按钮
        _telphoneText.clearButtonMode = UITextFieldViewModeAlways;
        _telphoneText.keyboardType = UIKeyboardTypePhonePad;
    }
    return _telphoneText;
}


-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line1;
    
}

-(UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line3;
    
}

-(UIButton *)countDown{
    if (!_countDown) {
        _countDown = [[UIButton alloc] init];
        
        _countDown.titleLabel.textColor = white_color;
        
        [_countDown setTitle:@" 验证码 " forState:UIControlStateNormal];
        _countDown.userInteractionEnabled = YES;
        _countDown.titleLabel.font = H14;
        [_countDown addTarget:self action:@selector(startTime:) forControlEvents:UIControlEventTouchUpInside];
        
        [_countDown.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_countDown.layer setCornerRadius:10];
        
        [_countDown.layer setBorderWidth:6];//设置边界的宽度
        
        [_countDown setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        
        [_countDown.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    
    return _countDown;
}


-(void)startTime:(UIButton *)button{
    
    if (![self.telphoneText.text isVaildTelphone]) {
        ShowErrorStatus(@"请输入正确的手机号");
        return;
    }
    
    self.changeTelphoneViewModel.telphone = self.telphoneText.text;
    [self.changeTelphoneViewModel.sendclickCommand execute:nil];
    
    __block int timeout = 30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //设置界面的按钮显示 根据自己需求设置
                [button setTitle:@" 验证码 " forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
           
                [button setBackgroundColor:MAIN_ORANGER];
                //设置按钮的边界颜色
                [button.layer setBorderColor:MAIN_ORANGER.CGColor];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [button setTitle:[NSString stringWithFormat:@" %@秒后 ",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                
                button.userInteractionEnabled = NO;
                [button setBackgroundColor:MAIN_ENABLE];
                //设置按钮的边界颜色
                [button.layer setBorderColor:MAIN_ENABLE.CGColor];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


-(UIImageView *)validateImg{
    if (!_validateImg) {
        _validateImg = [[UIImageView alloc] init];
        _validateImg.image = ImageNamed(@"Login_password_picture");
    }
    return _validateImg;
}

-(UITextField *)validateText{
    if (!_validateText) {
        _validateText = [[UITextField alloc] init];
        
        _validateText.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _validateText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //当输入框没有内容时，水印提示 提示内容为password
        _validateText.placeholder = @"输入验证码";
        
        //修改account的placeholder的字体颜色、大小
        [_validateText setValue: MAIN_TEXTFIELD forKeyPath:@"_placeholderLabel.textColor"];
        [_validateText setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _validateText.font = H14;
        // 设置右边永远显示清除按钮
        _validateText.clearButtonMode = UITextFieldViewModeAlways;
        
        _validateText.keyboardType = UIKeyboardTypePhonePad;
    }
    return _validateText;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line2;
}

-(UIButton *)next{
    if (!_next) {
        _next = [[UIButton alloc] init];
        
        [_next setTitle:@"提交" forState:UIControlStateNormal];
        _next.titleLabel.textColor = white_color;
        _next.titleLabel.font = H20;
        [_next addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        
        [_next.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_next.layer setCornerRadius:10];
        
        [_next.layer setBorderWidth:2];//设置边界的宽度
        
        [_next setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        
        [_next.layer setBorderColor:MAIN_ORANGER.CGColor];
        
    }
    return _next;
    
}

-(void)next:(UIButton *)button{
    if ([self.validateText.text isEqualToString:self.backNumber]) {
        NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
        
        self.changeTelphoneViewModel.companyCode = companyCode;
        UserModel *user =  getModel(@"user");
        self.changeTelphoneViewModel.userCode = user.userCode;
        
        [self.changeTelphoneViewModel.changeTelphoneCommand execute:nil];
        self.next.enabled = NO;
        [self.next setBackgroundColor:MAIN_ENABLE];
        //设置按钮的边界颜色
        [self.next.layer setBorderColor:MAIN_ENABLE.CGColor];
    }else{
        ShowErrorStatus(@"验证码不正确");
        self.validateText.text = @"";
        self.next.enabled = YES;
        [self.next setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        [self.next.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
}




@end
