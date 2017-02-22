//
//  ForgetPwdView.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ForgetPwdView.h"
#import "ForgetPwdViewModel.h"
#import "UserModel.h"

@interface ForgetPwdView()


@property(nonatomic,strong) ForgetPwdViewModel *forgetPwdViewModel;

@property(nonatomic,strong) UIImageView *forgetPwdImg;

@property(nonatomic,strong) UITextField *forgetPwdTextField;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIImageView *sureForgetPwdImg;

@property(nonatomic,strong) UITextField *sureForgetPwdTextField;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIButton *finish;

@end

@implementation ForgetPwdView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.forgetPwdViewModel = (ForgetPwdViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}


-(void)updateConstraints{
    
    WS(weakSelf);
    CGFloat leftPadding =(SCREEN_WIDTH-SCREEN_WIDTH*0.8)*0.5;
    CGFloat topPadding = SCREEN_HEIGHT *0.1;

    CGFloat length = SCREEN_WIDTH-SCREEN_WIDTH*0.35;
    
    [self.forgetPwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topPadding);
        make.left.equalTo(leftPadding);
        
    }];
    [self.forgetPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.forgetPwdImg);
        make.left.equalTo(weakSelf.forgetPwdImg.mas_right).offset([self h_w:10]);
        make.size.equalTo(CGSizeMake(length, [self h_w:30]));
    }];

    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding*2,1));
        make.right.equalTo(-leftPadding);
        make.top.equalTo(weakSelf.forgetPwdImg.mas_bottom).offset([self h_w:15]);
        
    }];
    
    [self.sureForgetPwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.forgetPwdImg);
        make.top.equalTo(weakSelf.line1.mas_bottom).offset([self h_w:15]);
    }];
    
    [self.sureForgetPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.sureForgetPwdImg);
        make.left.equalTo(weakSelf.sureForgetPwdImg.mas_right).offset([self h_w:10]);
        make.size.equalTo(CGSizeMake(length, [self h_w:30])); 
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding*2,1));
        make.right.equalTo(-leftPadding);
        make.top.equalTo(weakSelf.sureForgetPwdImg.mas_bottom).offset([self h_w:15]);
    }];
    
    
    [self.finish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line2.mas_bottom).offset([self h_w:15]);
        make.left.equalTo(weakSelf.line2);
        make.right.equalTo(weakSelf.line2);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.forgetPwdImg];
    [self addSubview:self.forgetPwdTextField];
    [self addSubview:self.line1];
    [self addSubview:self.sureForgetPwdImg];
    [self addSubview:self.sureForgetPwdTextField];
    [self addSubview:self.line2];
    [self addSubview:self.finish];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [self addDynamic:self];
}

#pragma mark lazyload
-(ForgetPwdViewModel *)forgetPwdViewModel{
    if (!_forgetPwdViewModel) {
        _forgetPwdViewModel = [[ForgetPwdViewModel alloc] init];
    }
    return _forgetPwdViewModel;
}


-(UIImageView *)forgetPwdImg{
    if (!_forgetPwdImg) {
        _forgetPwdImg = [[UIImageView alloc] init];
        _forgetPwdImg.image = ImageNamed(@"Login_password_picture");
    }
    return _forgetPwdImg;
    
}

-(UITextField *)forgetPwdTextField{
    if (!_forgetPwdTextField) {
        _forgetPwdTextField = [[UITextField alloc] init];
        
        _forgetPwdTextField.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _forgetPwdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        
        //当输入框没有内容时，水印提示 提示内容为password
        _forgetPwdTextField.placeholder = @"输入你的密码";
        
        //修改account的placeholder的字体颜色、大小
        [_forgetPwdTextField setValue: MAIN_TEXTFIELD forKeyPath:@"_placeholderLabel.textColor"];
        [_forgetPwdTextField setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _forgetPwdTextField.font = H14;
        // 设置右边永远显示清除按钮
        _forgetPwdTextField.clearButtonMode = UITextFieldViewModeAlways;
        
    }
    return _forgetPwdTextField;
    
}

-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_GRAY;
    }
    return _line1;
}

-(UIImageView *)sureForgetPwdImg{
    if (!_sureForgetPwdImg) {
        _sureForgetPwdImg = [[UIImageView alloc] init];
        _sureForgetPwdImg.image = ImageNamed(@"Login_password_picture");
    }
    return _sureForgetPwdImg;
}


-(UITextField *)sureForgetPwdTextField{
    if (!_sureForgetPwdTextField) {
        _sureForgetPwdTextField = [[UITextField alloc] init];
        
        _sureForgetPwdTextField.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _sureForgetPwdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        
        //当输入框没有内容时，水印提示 提示内容为password
        _sureForgetPwdTextField.placeholder = @"再次输入你的密码";
        
        //修改account的placeholder的字体颜色、大小
        [_sureForgetPwdTextField setValue: MAIN_TEXTFIELD forKeyPath:@"_placeholderLabel.textColor"];
        [_sureForgetPwdTextField setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _sureForgetPwdTextField.font = H14;
        // 设置右边永远显示清除按钮
        _sureForgetPwdTextField.clearButtonMode = UITextFieldViewModeAlways;
    }
    
    return _sureForgetPwdTextField;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_GRAY;
    }
    return _line2;
    
}


-(UIButton *)finish{
    if (!_finish) {
        _finish = [[UIButton alloc] init];

        [_finish setTitle:@"完成" forState:UIControlStateNormal];
        _finish.titleLabel.textColor = white_color;
        _finish.titleLabel.font = H20;
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
    
    if ([self.forgetPwdTextField.text isEqualToString:self.sureForgetPwdTextField.text]) {
        self.forgetPwdViewModel.pwd = self.forgetPwdTextField.text;
        UserModel *user = getModel(@"user");
        self.forgetPwdViewModel.telphone = user.userTelphone;
        [self.forgetPwdViewModel.sendclickCommand execute:nil];
    }else{
        ShowErrorStatus(@"密码不一致");
        self.forgetPwdTextField.text = @"";
        self.sureForgetPwdTextField.text = @"";
    }
}

@end
