//
//  ForgetView.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ForgetView.h"
#import "ForgetViewModel.h"

@interface ForgetView()

@property(nonatomic,strong) ForgetViewModel *forgetViewModel;

@property(nonatomic,strong) UIImageView *useImg;

@property(nonatomic,strong) UITextField *useText;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UILabel *hintText;

@property(nonatomic,strong) UIButton *countDown;

@property(nonatomic,strong) UIImageView *validateImg;

@property(nonatomic,strong) UITextField *validateText;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIButton *next;

@end

@implementation ForgetView

#pragma mark 初始化
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.forgetViewModel = (ForgetViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    
    CGFloat leftPadding =(SCREEN_WIDTH-SCREEN_WIDTH*0.8)*0.5;
    CGFloat topPadding = SCREEN_HEIGHT *0.1;
    CGFloat length = SCREEN_WIDTH-SCREEN_WIDTH*0.35;

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
    
    [self.hintText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1.mas_bottom).offset(15);
        make.left.equalTo(leftPadding);
    }];
    
    [self.countDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.hintText);
        make.right.equalTo(weakSelf.line1);
        
    }];
    
    [self.validateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.useImg);
        make.top.equalTo(weakSelf.hintText.mas_bottom).offset(15);
    }];
    
    [self.validateText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.useText);
        make.centerY.equalTo(weakSelf.validateImg);
        make.size.equalTo(CGSizeMake(length, 35));
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.validateImg.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
    }];
    
    [self.next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line2.mas_bottom).offset(15);
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
    [self addSubview:self.hintText];
    [self addSubview:self.countDown];
    [self addSubview:self.validateImg];
    [self addSubview:self.validateText];
    [self addSubview:self.line2];
    [self addSubview:self.next];

    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    
}


#pragma mark lazyload
-(ForgetViewModel *)forgetViewModel{
    if (!_forgetViewModel) {
        _forgetViewModel = [[ForgetViewModel alloc] init];
    }
    return _forgetViewModel;
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
        _useText.placeholder = @"输入手机号";
        
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

-(UILabel *)hintText{
    if (!_hintText) {
        _hintText = [[UILabel alloc] init];
        _hintText.font = H14;
        _hintText.text = @"验证码30分钟内有效";
        _hintText.textColor = RGBCOLOR(199, 199, 199);
    }
    return _hintText;
}

-(UIButton *)countDown{
    if (!_countDown) {
        _countDown = [[UIButton alloc] init];
        
        _countDown.titleLabel.textColor = white_color;
        
        [_countDown setTitle:@"  获取验证码  " forState:UIControlStateNormal];
        _countDown.userInteractionEnabled = YES;
        _countDown.titleLabel.font = H14;
        [_countDown addTarget:self action:@selector(startTime:) forControlEvents:UIControlEventTouchUpInside];
        
        [_countDown.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_countDown.layer setCornerRadius:10];
        
        [_countDown.layer setBorderWidth:2];//设置边界的宽度
        
        [_countDown setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){242/255.f,130/255.f,74/255.f,1});
        
        [_countDown.layer setBorderColor:color];
    }
    
    return _countDown;
}


-(void)startTime:(UIButton *)button{
  
    
    __block int timeout = 30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [button setTitle:@"发送验证码" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [button setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                button.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


-(UIImageView *)validateImg{
    if (!_validateImg) {
        _validateImg = [[UIImageView alloc] init];
        _validateImg.image = ImageNamed(@"login_phone_picture");
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
        [_validateText setValue: [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [_validateText setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _validateText.font = H14;
        // 设置右边永远显示清除按钮
        _validateText.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _validateText;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_GRAY;
    }
    return _line2;
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
    [self.forgetViewModel.forgetPwdclickSubject sendNext:nil];
    
}


@end
