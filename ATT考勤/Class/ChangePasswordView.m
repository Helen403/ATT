//
//  ChangePasswordView.m
//  ATT考勤
//
//  Created by Helen on 17/2/21.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChangePasswordView.h"
#import "ChangePasswordViewModel.h"
#import "UserModel.h"

@interface ChangePasswordView()

@property(nonatomic,strong) ChangePasswordViewModel *changePasswordViewModel;

@property(nonatomic,strong) UIImageView *useImg;

@property(nonatomic,strong) UILabel *useLabel;

@property(nonatomic,strong) UITextField *useText;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIImageView *telphoneImg;

@property(nonatomic,strong) UILabel *telphoneLabel;

@property(nonatomic,strong) UITextField *telphoneText;



@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIImageView *validateImg;

@property(nonatomic,strong) UILabel *validateLabel;

@property(nonatomic,strong) UITextField *validateText;

@property(nonatomic,strong) UIView *line3;

@property(nonatomic,strong) UIButton *next;

@property(nonatomic,strong) NSString *backNumber;

@end

@implementation ChangePasswordView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.changePasswordViewModel = (ChangePasswordViewModel *)viewModel;
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
        make.left.equalTo(weakSelf.useLabel.mas_right).offset([self h_w:40]);
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

    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding*2,1));
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
    [[self.changePasswordViewModel.failSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.useText.text = @"";
            self.telphoneText.text = @"";
            self.validateText.text = @"";
        });
    }];

}



#pragma mark lazyload
-(ChangePasswordViewModel *)changePasswordViewModel{
    if (!_changePasswordViewModel) {
        _changePasswordViewModel = [[ChangePasswordViewModel alloc] init];
    }
    return _changePasswordViewModel;
}


-(UIImageView *)useImg{
    if (!_useImg) {
        _useImg = [[UIImageView alloc] init];
        _useImg.image = ImageNamed(@"Login_password_picture");
    }
    return _useImg;
}

-(UILabel *)useLabel{
    if (!_useLabel) {
        _useLabel = [[UILabel alloc] init];
        _useLabel.text = @"旧密码";
        _useLabel.textColor = MAIN_PAN_2;
        _useLabel.font = H14;
    }
    return _useLabel;
}

-(UITextField *)useText{
    if (!_useText) {
        _useText = [[UITextField alloc] init];
        
        _useText.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _useText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        
        //当输入框没有内容时，水印提示 提示内容为password
        _useText.placeholder = @"输入密码";
        
        //修改account的placeholder的字体颜色、大小
        [_useText setValue: MAIN_TEXTFIELD forKeyPath:@"_placeholderLabel.textColor"];
        [_useText setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _useText.font = H14;
        // 设置右边永远显示清除按钮
        _useText.secureTextEntry = YES;
        _useText.keyboardType = UIKeyboardTypePhonePad;
    }
    return _useText;
}

-(UIImageView *)telphoneImg{
    if (!_telphoneImg) {
        _telphoneImg = [[UIImageView alloc] init];
        _telphoneImg.image = ImageNamed(@"Login_password_picture");
    }
    return _telphoneImg;
}

-(UILabel *)telphoneLabel{
    if (!_telphoneLabel) {
        _telphoneLabel = [[UILabel alloc] init];
        _telphoneLabel.text = @"新密码";
        _telphoneLabel.textColor = MAIN_PAN_2;
        _telphoneLabel.font = H14;
    }
    return _telphoneLabel;
}

-(UILabel *)validateLabel{
    if (!_validateLabel) {
        _validateLabel = [[UILabel alloc] init];
        _validateLabel.text = @"再输入一次";
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
        _telphoneText.placeholder = @"输入密码";
        
        //修改account的placeholder的字体颜色、大小
        [_telphoneText setValue:MAIN_TEXTFIELD forKeyPath:@"_placeholderLabel.textColor"];
        [_telphoneText setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _telphoneText.font = H14;
        // 设置右边永远显示清除按钮
        _telphoneText.secureTextEntry = YES;
        //        _telphoneText.clearButtonMode = UITextFieldViewModeAlways;
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
        _validateText.placeholder = @"输入密码";
        
        //修改account的placeholder的字体颜色、大小
        [_validateText setValue: MAIN_TEXTFIELD forKeyPath:@"_placeholderLabel.textColor"];
        [_validateText setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _validateText.font = H14;
        // 设置右边永远显示清除按钮
        //        _validateText.clearButtonMode = UITextFieldViewModeAlways;
        _validateText.secureTextEntry = YES;
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
  
    
    if (self.useText.text.length == 0) {
        ShowErrorStatus(@"旧密码不能为空");
        return;
    }
    
    if (self.telphoneText.text.length == 0) {
        ShowErrorStatus(@"新密码不能为空");
        return;
    }
    
    if (self.validateText.text.length == 0) {
        ShowErrorStatus(@"确认密码不能为空");
        return;
    }
    
    if (self.telphoneText.text.length<6) {
        ShowErrorStatus(@"密码的长度不能少于6");
        return;
    }
    
    if (self.telphoneText.text.length>8) {
        ShowErrorStatus(@"密码的长度不能大于8");
        return;
    }
    
    
    if (![self.telphoneText.text isEqualToString:self.validateText.text]) {
        ShowErrorStatus(@"密码不一致");
        return;
    }
    
    if ([self.useText.text isEqualToString:self.telphoneText.text]) {
        ShowErrorStatus(@"新密码不能与旧密码相同");
        return;
    }
    
    NSString *password = [self.useText.text md5String];
    UserModel *user = getModel(@"user");
    if (![password isEqualToString:user.userPassword]) {
        
        ShowErrorStatus(@"旧密码不正确");
        return;
    }
    

    self.changePasswordViewModel.telphone = user.userTelphone;
    self.changePasswordViewModel.newpassword = self.validateText.text;
    [self.changePasswordViewModel.sendclickCommand execute:nil];
}



@end
