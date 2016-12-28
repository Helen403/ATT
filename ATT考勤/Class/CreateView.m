//
//  CreateView.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "CreateView.h"
#import "CreateViewModel.h"

@interface CreateView()

@property(nonatomic,strong) CreateViewModel *createViewModel;

@property(nonatomic,strong) UIImageView *useImg;

@property(nonatomic,strong) UITextField *useText;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIImageView *pwdImg;

@property(nonatomic,strong) UITextField *pwdText;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIImageView *surepwdImg;

@property(nonatomic,strong) UITextField *surepwdText;

@property(nonatomic,strong) UIView *line3;

@property(nonatomic,strong) UIButton *next;

@end

@implementation CreateView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.createViewModel = (CreateViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}


-(void)updateConstraints{
    
    WS(weakSelf);
    
    CGFloat leftPadding =(SCREEN_WIDTH-SCREEN_WIDTH*0.8)*0.5;
    CGFloat topPadding = SCREEN_HEIGHT *0.1;
    
    
    [self.useImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topPadding);
        make.left.equalTo(leftPadding);
    }];
    
    [self.useText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.useImg);
        make.left.equalTo(weakSelf.useImg.mas_right).offset(10);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding, 30));
    }];
    
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding*2,1));
        make.right.equalTo(-leftPadding);
        make.top.equalTo(weakSelf.useText.mas_bottom).offset(20);
        
    }];
    
    
    [self.pwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.line1);
    }];
    
    [self.pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.pwdImg);
        make.left.equalTo(weakSelf.pwdImg.mas_right).offset(10);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding, 30));
    }];
    
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding*2,1));
        make.right.equalTo(-leftPadding);
        make.top.equalTo(weakSelf.pwdText.mas_bottom).offset(20);
        
    }];
    
    
    [self.surepwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line2.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.line2);
    }];
    
    [self.surepwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.surepwdImg);
        make.left.equalTo(weakSelf.surepwdImg.mas_right).offset(10);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding, 30));
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding*2,1));
        make.right.equalTo(-leftPadding);
        make.top.equalTo(weakSelf.surepwdText.mas_bottom).offset(20);
        
    }];
    
    [self.next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line3.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.useImg];
    [self addSubview:self.useText];
    [self addSubview:self.line1];
    [self addSubview:self.pwdImg];
    [self addSubview:self.pwdText];
    [self addSubview:self.line2];
    [self addSubview:self.surepwdImg];
    [self addSubview:self.surepwdText];
    [self addSubview:self.line3];
    [self addSubview:self.next];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

-(void)h_bindViewModel{
    
    
}


#pragma mark lazyload
-(CreateViewModel *)createViewModel{
    if (!_createViewModel) {
        _createViewModel = [[CreateViewModel alloc] init];
    }
    return _createViewModel;
}

-(UIImageView *)useImg{
    if (!_useImg) {
        _useImg = [[UIImageView alloc] init];
        _useImg.image = ImageNamed(@"login_phone_picture");
    }
    return _useImg;
}


-(UITextField *)useText{
    if (!_useText) {
        _useText = [[UITextField alloc] init];
        
        _useText.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _useText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //当输入框没有内容时，水印提示 提示内容为password
        _useText.placeholder = @"输入用户名";
        
        //修改account的placeholder的字体颜色、大小
        [_useText setValue: [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [_useText setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _useText.font = H14;
        // 设置右边永远显示清除按钮
        _useText.clearButtonMode = UITextFieldViewModeAlways;
        
    }
    
    return _useText;
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

-(UITextField *)pwdText{
    if (!_pwdText) {
        _pwdText = [[UITextField alloc] init];
       
        
        _pwdText.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _pwdText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //当输入框没有内容时，水印提示 提示内容为password
        _pwdText.placeholder = @"输入你的密码";
        
        //修改account的placeholder的字体颜色、大小
        [_pwdText setValue: [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [_pwdText setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _pwdText.font = H14;
        // 设置右边永远显示清除按钮
        _pwdText.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _pwdText;
    
    
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_GRAY;
    }
    return _line2;
}


-(UIImageView *)surepwdImg{
    if (!_surepwdImg) {
        _surepwdImg = [[UIImageView alloc] init];
        _surepwdImg.image = ImageNamed(@"Login_password_picture");
    }
    return _surepwdImg;
    
}


-(UITextField *)surepwdText{
    if (!_surepwdText) {
        _surepwdText = [[UITextField alloc] init];
        
        _surepwdText.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _surepwdText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //当输入框没有内容时，水印提示 提示内容为password
        _surepwdText.placeholder = @"再次输入你的密码";
        
        //修改account的placeholder的字体颜色、大小
        [_surepwdText setValue: [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [_surepwdText setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _surepwdText.font = H14;
        // 设置右边永远显示清除按钮
        _surepwdText.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _surepwdText;
    
    
}

-(UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = MAIN_GRAY;
    }
    return _line3;
    
}

-(UIButton *)next{
    if (!_next) {
        _next = [[UIButton alloc] init];
        [_next setTitle:@"下一步" forState:UIControlStateNormal];
        _next.titleLabel.textColor = white_color;
        _next.titleLabel.font = H20;
        [_next addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        
        [_next.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_next.layer setCornerRadius:10];
        
        [_next.layer setBorderWidth:2];//设置边界的宽度
        
        [_next setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){242/255.f,130/255.f,74/255.f,1});
        
        [_next.layer setBorderColor:color];
    }
    return _next;
    
}

-(void)next:(UIButton *)button{
    
    [self.createViewModel.buildRoleclickSubject sendNext:nil];
}
@end
