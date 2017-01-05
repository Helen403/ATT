//
//  ApplicationView.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ApplicationView.h"
#import "ApplicationViewModel.h"

#import "ProveView.h"
#import "ApplyManView.h"

@interface ApplicationView()

@property(nonatomic,strong) ApplicationViewModel *applicationViewModel;

@property(nonatomic,strong) UILabel *applyTimeText;

@property(nonatomic,strong) UILabel *applyTimeShowText;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UILabel *lateTimeText;

@property(nonatomic,strong) UILabel *lateTimeShowText;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UILabel *sureTimeText;

@property(nonatomic,strong) UILabel *sureTimeShowText;

@property(nonatomic,strong) UIView *line3;

@property(nonatomic,strong) UITextView *textView;

@property(nonatomic,strong) ProveView *proveView;

@property(nonatomic,strong) ApplyManView *applyManView;

@property(nonatomic,strong) UIButton *finish;

@end

@implementation ApplicationView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{

    self.applicationViewModel = (ApplicationViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{

    WS(weakSelf);
    
    CGFloat padding = [self h_w:15];
    CGFloat length = [self h_w:160];
    
    [self.applyTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo(padding);
    }];
    
    [self.applyTimeShowText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-[self h_w:10]);
        make.centerY.equalTo(weakSelf.applyTimeText);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.applyTimeText.mas_bottom).offset(padding);
        make.left.equalTo([self h_w:10]);
        make.right.equalTo(-[self h_w:10]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.lateTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.applyTimeText);
    }];
    
    [self.lateTimeShowText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lateTimeText);
        make.left.equalTo(weakSelf.applyTimeShowText);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lateTimeText.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.sureTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line2.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.applyTimeText);
    }];
    
    [self.sureTimeShowText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sureTimeText);
        make.left.equalTo(weakSelf.applyTimeShowText);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sureTimeText.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line3.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, length));
    }];
    
    [self.proveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textView.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, length*0.5));
    }];
    
    [self.applyManView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.proveView.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, length*0.5));
    }];
    
    [self.finish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.applyManView.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.line1);
        make.right.equalTo(weakSelf.line1);

    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{

    
    [self addSubview:self.applyTimeText];
    [self addSubview:self.applyTimeShowText];
    [self addSubview:self.line1];
    [self addSubview:self.lateTimeText];
    [self addSubview:self.lateTimeShowText];
    [self addSubview:self.line2];
    [self addSubview:self.sureTimeText];
    [self addSubview:self.sureTimeShowText];
    [self addSubview:self.line3];
    [self addSubview:self.textView];
    [self addSubview:self.proveView];
    [self addSubview:self.applyManView];
    [self addSubview:self.finish];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{


}



#pragma mark lazyload
-(ApplicationViewModel *)applicationViewModel{
    if (!_applicationViewModel) {
        _applicationViewModel = [[ApplicationViewModel alloc] init];
    }
    return _applicationViewModel;
}


-(UILabel *)applyTimeText{
    if (!_applyTimeText) {
        _applyTimeText = [[UILabel alloc] init];
        _applyTimeText.text = @"申请时间";
        _applyTimeText.textColor = MAIN_PAN;
        _applyTimeText.font = H14;
    }
    return _applyTimeText;
}

-(UILabel *)applyTimeShowText{
    if (!_applyTimeShowText) {
        _applyTimeShowText = [[UILabel alloc] init];
        _applyTimeShowText.text = @"2016年12月25日 08:30:00";
        _applyTimeShowText.font = H14;
        _applyTimeShowText.textColor = MAIN_PAN;
    }
    return _applyTimeShowText;
}

-(UIView *)line1{

    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = LINE_COLOR;
    }
    return _line1;
}

-(UILabel *)lateTimeText{
    if (!_lateTimeText) {
        _lateTimeText = [[UILabel alloc] init];
        _lateTimeText.text = @"迟到时间";
        _lateTimeText.textColor = MAIN_PAN;
        _lateTimeText.font = H14;
    }
    return _lateTimeText;
}

-(UILabel *)lateTimeShowText{
    if (!_lateTimeShowText) {
        _lateTimeShowText = [[UILabel alloc] init];
        _lateTimeShowText.text = @"2016年12月25日 08:30:00";
        _lateTimeShowText.font = H14;
        _lateTimeShowText.textColor = MAIN_PAN;
    }
    return _lateTimeShowText;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = LINE_COLOR;
    }
    return _line2;
}

-(UILabel *)sureTimeText{
    if (!_sureTimeText) {
        _sureTimeText = [[UILabel alloc] init];
        _sureTimeText.text = @"正常时间";
        _sureTimeText.textColor = MAIN_PAN;
        _sureTimeText.font = H14;
    }
    return _sureTimeText;

}

-(UILabel *)sureTimeShowText{
    if (!_sureTimeShowText) {
        _sureTimeShowText = [[UILabel alloc] init];
        _sureTimeShowText.text = @"2016年12月25日 08:30:00";
        _sureTimeShowText.font = H14;
        _sureTimeShowText.textColor = MAIN_PAN;
    }
    return _sureTimeShowText;
}

-(UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = LINE_COLOR;
    }
    return _line3;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView  = [[UITextView alloc] init];
//        _textView.backgroundColor = yellow_color;

        _textView.scrollEnabled = NO;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
        _textView.editable = YES;        //是否允许编辑内容，默认为“YES”
//        _textView.delegate = self;       //设置代理方法的实现类
        _textView.font=[UIFont fontWithName:@"Arial" size:18.0]; //设置字体名字和字体大小;
//        _textView.returnKeyType = UIReturnKeyDefault;//return键的类型
//        _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _textView.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        _textView.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
        _textView.textColor = MAIN_PAN;
        _textView.text = @"迟到原因";//设置显示的文本内容
        
        _textView.layer.borderColor = LINE_COLOR.CGColor;
        _textView.layer.borderWidth =1.0;
        _textView.layer.cornerRadius =5.0;
        _textView.font = H14;
        
    }
    return _textView;
}

-(ProveView *)proveView{
    if (!_proveView) {
        _proveView = [[ProveView alloc] init];
        _proveView.layer.borderColor = LINE_COLOR.CGColor;
        _proveView.layer.borderWidth =1.0;
        _proveView.layer.cornerRadius =5.0;
    }
    return _proveView;
}

-(ApplyManView *)applyManView{
    if (!_applyManView) {
        _applyManView = [[ApplyManView alloc] init];
        
        _applyManView.layer.borderColor = LINE_COLOR.CGColor;
        _applyManView.layer.borderWidth =1.0;
        _applyManView.layer.cornerRadius =5.0;
    }
    return _applyManView;
}

-(UIButton *)finish{
    if (!_finish) {
        _finish = [[UIButton alloc] init];
        [_finish setTitle:@"提交申请" forState:UIControlStateNormal];
        _finish.titleLabel.font = H22;
        [_finish addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
        
        [_finish.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_finish.layer setCornerRadius:10];
        
        [_finish.layer setBorderWidth:2];//设置边界的宽度
        
        [_finish setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){242/255.f,130/255.f,74/255.f,1});
        
        [_finish.layer setBorderColor:color];
    }
    
    return _finish;
}

-(void)finish:(UIButton *)button{
    [self.applicationViewModel.submitclickSubject sendNext:nil];

}

@end
