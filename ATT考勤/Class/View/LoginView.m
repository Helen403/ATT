//
//  LoginView.m
//  ATT考勤
//
//  Created by Helen on 16/12/22.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "LoginView.h"
#import "LoginViewModel.h"

@interface LoginView()

@property(nonatomic,strong) LoginViewModel *loginViewModel;

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UIImageView *useImg;

@property(nonatomic,strong) UITextField *useTextField;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIImageView *pwdImg;

@property(nonatomic,strong) UITextField *pwdTextField;

@property(nonatomic,strong) UIButton *login;

@property(nonatomic,strong) UILabel *forgetText;

@property(nonatomic,strong) UILabel *registerText;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UILabel *ThirdText;

@property(nonatomic,strong) UIImageView *weixin;

@property(nonatomic,strong) UIImageView *QQ;

@property(nonatomic,strong) UIImageView *sina;

@property(nonatomic,strong) UIButton *eyes;

@end


@implementation LoginView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.loginViewModel = (LoginViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    
    CGFloat leftPadding =(SCREEN_WIDTH-SCREEN_WIDTH*0.8)*0.5;
    CGFloat length = SCREEN_WIDTH-SCREEN_WIDTH*0.35;
    CGFloat biglength = [self h_w:50];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo([self h_w:80]);
    }];
    
    [self.useImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding+[self h_w:10]);
        make.top.equalTo(weakSelf.icon.mas_bottom).offset([self h_w:80]);
    }];
    
    [self.useTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.useImg.mas_right).offset([self h_w:10]);
        make.centerY.equalTo(weakSelf.useImg);
        make.size.equalTo(CGSizeMake(length, [self h_w:25]));
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.right.equalTo(-leftPadding);
        make.top.equalTo(weakSelf.useTextField.mas_bottom).offset([self h_w:20]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH,1));
    }];
    
    [self.pwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1.mas_bottom).offset([self h_w:20]);
        make.left.equalTo(weakSelf.useImg);
    }];
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.pwdImg.mas_right).offset([self h_w:10]);
        make.centerY.equalTo(weakSelf.pwdImg);
        make.size.equalTo(CGSizeMake(length-[self h_w:30], [self h_w:25]));
    }];
    
    [self.eyes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.pwdImg);
        make.left.equalTo(weakSelf.pwdTextField.mas_right).offset([self h_w:2]);
    }];
    
    
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pwdImg.mas_bottom).offset([self h_w:50]);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
    }];
    
    [self.forgetText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.login.mas_bottom).offset([self h_w:15]);
        make.left.equalTo(weakSelf.line1);
    }];
    
    [self.registerText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.login.mas_bottom).offset([self h_w:15]);
        make.right.equalTo(weakSelf.line1);
    }];
    
    
    [self.weixin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[self h_w:40]);
        make.left.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(biglength, biglength));
    }];
    
    [self.QQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.weixin);
        make.size.equalTo(CGSizeMake(biglength, biglength));
    }];
    
    [self.sina mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.line1);
        make.top.equalTo(weakSelf.weixin);
        make.size.equalTo(CGSizeMake(biglength, biglength));
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.weixin.mas_top).offset(-[self h_w:25]);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH,1));
    }];
    
    [self.ThirdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.line2);
    }];
    
    
    [super updateConstraints];
}


#pragma mark private
-(void)h_setupViews{
    [self setBackgroundColor:white_color];
    
    [self addSubview:self.icon];
    [self addSubview:self.useImg];
    [self addSubview:self.useTextField];
    [self addSubview:self.line1];
    [self addSubview:self.pwdImg];
    [self addSubview:self.pwdTextField];
    [self addSubview:self.login];
    [self addSubview:self.forgetText];
    [self addSubview:self.registerText];
    [self addSubview:self.line2];
    [self addSubview:self.ThirdText];
    [self addSubview:self.weixin];
    [self addSubview:self.QQ];
    [self addSubview:self.sina];
    [self addSubview:self.eyes];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    
}


#pragma mark lazyload
-(LoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc] init];
        
    }
    return _loginViewModel;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc] init];
        _icon.image = ImageNamed(@"login_ATT_picture");
    }
    return _icon;
}

-(UIImageView *)useImg{
    if (!_useImg) {
        _useImg = [[UIImageView alloc] init];
        _useImg.image = ImageNamed(@"login_phone_picture");
        
    }
    
    return _useImg;
}

-(UITextField *)useTextField{
    if (!_useTextField) {
        _useTextField = [[UITextField alloc] init];
        
        _useTextField.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _useTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //当输入框没有内容时，水印提示 提示内容为password
        _useTextField.placeholder = @"输入手机号";
        
        //修改account的placeholder的字体颜色、大小
        [_useTextField setValue: [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [_useTextField setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _useTextField.font = H14;
        // 设置右边永远显示清除按钮
        _useTextField.clearButtonMode = UITextFieldViewModeAlways;
        
    }
    return _useTextField;
}

-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_GRAY;
        
    }
    return _line1;
}

-(UIImageView *)pwdImg{
    if (!_pwdImg) {
        _pwdImg = [[UIImageView alloc] init];
        _pwdImg.image = ImageNamed(@"Login_password_picture");
    }
    return _pwdImg;
}

-(UITextField *)pwdTextField{
    if (!_pwdTextField) {
        _pwdTextField = [[UITextField alloc] init];
        
        _pwdTextField.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _pwdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //当输入框没有内容时，水印提示 提示内容为password
        _pwdTextField.placeholder = @"密 码";
        
        //修改account的placeholder的字体颜色、大小
        [_pwdTextField setValue: [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [_pwdTextField setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _pwdTextField.font = H14;
        // 设置右边永远显示清除按钮
        //        _pwdTextField.clearButtonMode = UITextFieldViewModeAlways;
        _pwdTextField.secureTextEntry = YES;
//        _pwdTextField.delegate = self;
        
        //        // 5.监听文本框的文字改变
        //        [_pwdTextField.rac_textSignal subscribeNext:^(id x) {
        //
        //            NSLog(@"文字改变了%@",x);
        //        }];
    }
    return _pwdTextField;
    
}


//- (void) textChangeAction:(id) sender {
//   
//}


-(UIButton *)login{
    if (!_login) {
        _login = [[UIButton alloc] init];
        [_login setTitle:@"登   陆" forState:UIControlStateNormal];
        _login.titleLabel.font = H22;
        [_login addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        
        [_login.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_login.layer setCornerRadius:10];
        
        [_login.layer setBorderWidth:2];//设置边界的宽度
        
        [_login setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){242/255.f,130/255.f,74/255.f,1});
        
        [_login.layer setBorderColor:color];
        
    }
    
    return _login;
}

-(void)login:(UIButton *)button{
    
    if (self.useTextField.text.length>0&&self.pwdTextField.text.length>0) {
      
    }
    //点击后不然再点击
    self.loginViewModel.user = self.useTextField.text;
    self.loginViewModel.pwd = self.pwdTextField.text;
    
    //登陆成功后发送按钮
    [self.loginViewModel.loginclickCommand execute:nil];
    
  
}


-(UILabel *)forgetText{
    if (!_forgetText) {
        _forgetText = [[UILabel alloc] init];
        _forgetText.text = @"忘记密码";
        _forgetText.textColor = RGBCOLOR(129, 130, 132);
        _forgetText.font = H14;
        //添加点击事件
        _forgetText.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forget)];
        [_forgetText addGestureRecognizer:setTap];
    }
    return _forgetText;
}

-(void)forget{
    [self.loginViewModel.forgetclickSubject sendNext:nil];
}


-(UILabel *)registerText{
    if (!_registerText) {
        _registerText = [[UILabel alloc] init];
        _registerText.text = @"快速注册";
        _registerText.textColor = RGBCOLOR(231, 127, 72);
        _registerText.font = H14;
        //添加点击事件
        _registerText.userInteractionEnabled=YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registerClick)];
        [_registerText addGestureRecognizer:setTap];
        
    }
    return _registerText;
}

-(void)registerClick{
    
    [self.loginViewModel.newpartclickSubject sendNext:nil];
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_GRAY;
    }
    return _line2;
    
}

-(UILabel *)ThirdText{
    if (!_ThirdText) {
        _ThirdText = [[UILabel alloc] init];
        _ThirdText.text = @" 使用第三方登陆 ";
        _ThirdText.font = H12;
        _ThirdText.textColor = RGBCOLOR(181, 182, 184);
        _ThirdText.backgroundColor = white_color;
    }
    return _ThirdText;
}

-(UIImageView *)weixin{
    
    if (!_weixin) {
        _weixin = [[UIImageView alloc] init];
        _weixin.image = ImageNamed(@"login_weixin_picture");
        _weixin.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weixinClick)];
        [_weixin addGestureRecognizer:setTap];
        
    }
    return _weixin;
}

-(void)weixinClick{
    
    [self.loginViewModel.weixinclickSubject sendNext:nil];
}


-(UIImageView *)QQ{
    if (!_QQ) {
        _QQ = [[UIImageView alloc] init];
        _QQ.image = ImageNamed(@"login_QQ_picture");
        _QQ.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QQclick)];
        [_QQ addGestureRecognizer:setTap];
    }
    return _QQ;
}


-(void)QQclick{
    
    [self.loginViewModel.qqclickSubject sendNext:nil];
}

-(UIImageView *)sina{
    if (!_sina) {
        _sina = [[UIImageView alloc] init];
        _sina.image = ImageNamed(@"login_weibo_picture");
        _sina.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Sinaclick)];
        [_sina addGestureRecognizer:setTap];
    }
    return _sina;
    
}

-(void)Sinaclick{
    [self.loginViewModel.sinaclickSubject sendNext:nil];
}

-(UIButton *)eyes{
    if (!_eyes) {
        _eyes = [[UIButton alloc] init];
        
        [_eyes addTarget:self action:@selector(showAndHidePassword:) forControlEvents:UIControlEventTouchUpInside];
        [_eyes setImage:ImageNamed(@"eyes") forState:UIControlStateNormal];
    }
    return _eyes;
    
}

//隐藏和显示密码
-(void)showAndHidePassword:(UIButton *)sender{
    //避免明文/密文切换后光标位置偏移
    self.pwdTextField.enabled = NO;    // the first one;
    self.pwdTextField.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
    self.pwdTextField.enabled = YES;  // the second one;
    [self.pwdTextField becomeFirstResponder]; // the third one
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //明文切换密文后避免被清空
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.pwdTextField && textField.isSecureTextEntry) {
        textField.text = toBeString;
        return NO;
    }
    return YES;
}


@end
