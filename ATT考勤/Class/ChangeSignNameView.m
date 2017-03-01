//
//  ChangeSignNameView.m
//  ATT考勤
//
//  Created by Helen on 17/3/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChangeSignNameView.h"
#import "ChangeSignNameViewModel.h"
#import "UserModel.h"


@interface ChangeSignNameView()

@property(nonatomic,strong) ChangeSignNameViewModel *changeSignNameViewModel;

@property(nonatomic,strong) UITextField *useTextField;

@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UIButton *next;

@end

@implementation ChangeSignNameView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.changeSignNameViewModel = (ChangeSignNameViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    
    [self.useTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([self h_w:20]);
        make.centerX.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-[self h_w:20], [self h_w:25]));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.useTextField.mas_bottom).offset([self h_w:10]);
        make.centerX.equalTo(weakSelf);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-[self h_w:20], [self h_w:1]));
    }];
    
    
    [self.next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line.mas_bottom).offset([self h_w:20]);
        make.left.equalTo(weakSelf.line);
        make.right.equalTo(weakSelf.line);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    
    [self addSubview:self.useTextField];
    [self addSubview:self.line];
    [self addSubview:self.next];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    //修改签名失败
    [[self.changeSignNameViewModel.failSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.useTextField.text = @"";
            
        });
    }];
}


#pragma mark lazyload
-(ChangeSignNameViewModel *)changeSignNameViewModel{
    if (!_changeSignNameViewModel) {
        _changeSignNameViewModel = [[ChangeSignNameViewModel alloc] init];
    }
    return _changeSignNameViewModel;
}


#pragma mark lazyload

-(UITextField *)useTextField{
    if (!_useTextField) {
        _useTextField = [[UITextField alloc] init];
        
        _useTextField.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _useTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //当输入框没有内容时，水印提示 提示内容为password
        _useTextField.placeholder = @"请输入新签名";
        _useTextField.tintColor = MAIN_PAN_2;
        _useTextField.textColor = MAIN_PAN_2;
        //修改account的placeholder的字体颜色、大小
        [_useTextField setValue: MAIN_TEXTFIELD forKeyPath:@"_placeholderLabel.textColor"];
        [_useTextField setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _useTextField.font = H14;
        // 设置右边永远显示清除按钮
        _useTextField.clearButtonMode = UITextFieldViewModeAlways;
        //_useTextField.delegate = self;//设置代理
        
        // 5.监听文本框的文字改变
        [_useTextField becomeFirstResponder];
        
    }
    return _useTextField;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
    }
    return _line;
}

-(UIButton *)next{
    if (!_next) {
        _next = [[UIButton alloc] init];
        [_next setTitle:@"保存" forState:UIControlStateNormal];
        _next.titleLabel.font = H22;
        [_next addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        
        [_next.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_next.layer setCornerRadius:10];
        
        [_next.layer setBorderWidth:2];//设置边界的宽度
        
        [_next setBackgroundColor:MAIN_ORANGER];
        
        [_next.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    return _next;
}

-(void)save{
    if (self.useTextField.text.length>0) {
        
        UserModel *user =  getModel(@"user");
        self.changeSignNameViewModel.userCode = user.userCode;
        self.changeSignNameViewModel.userSignName = self.useTextField.text;
        [self.changeSignNameViewModel.refreshDataCommand  execute:nil];
        
    }else{
        ShowMessage(@"新的签名不能为空");
    }
}

@end
