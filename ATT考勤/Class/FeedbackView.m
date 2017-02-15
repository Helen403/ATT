//
//  FeedbackView.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "FeedbackView.h"
#import "FeedbackViewModel.h"

@interface FeedbackView()

@property(nonatomic,strong) FeedbackViewModel *feedbackViewModel;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UITextView *mySuggestion;

@property(nonatomic,strong) UILabel *suggest;

@property(nonatomic,strong) UIButton *addTo;

@end

@implementation FeedbackView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.feedbackViewModel = (FeedbackViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([self h_w:10]);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.mySuggestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:10]);
        make.left.equalTo([self h_w:10]);
        make.right.equalTo(-[self h_w:10]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:170]));
    }];
    
    [self.suggest mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(weakSelf.mySuggestion.mas_bottom).offset([self h_w:10]);
        make.left.equalTo([self h_w:10]);
        
    }];
    
    [self.addTo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggest.mas_bottom).offset([self h_w:10]);
        make.left.equalTo([self h_w:10]);
        make.right.equalTo(-[self h_w:10]);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.mySuggestion];
    [self addSubview:self.suggest];
    [self addSubview:self.addTo];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(FeedbackViewModel *)feedbackViewModel{
    if (!_feedbackViewModel) {
        _feedbackViewModel = [[FeedbackViewModel alloc] init];
    }
    return _feedbackViewModel;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"我的意见";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UITextView *)mySuggestion{
    if (!_mySuggestion) {
        _mySuggestion = [[UITextView alloc] init];
        _mySuggestion.scrollEnabled = NO;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
        _mySuggestion.editable = YES;        //是否允许编辑内容，默认为“YES”
        //        _textView.delegate = self;       //设置代理方法的实现类
        _mySuggestion.font=[UIFont fontWithName:@"Arial" size:18.0]; //设置字体名字和字体大小;
        //        _textView.returnKeyType = UIReturnKeyDefault;//return键的类型
        //        _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _mySuggestion.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        _mySuggestion.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
        _mySuggestion.textColor = MAIN_PAN;
        _mySuggestion.text = @"注册账户不能正常登陆";//设置显示的文本内容
        
        _mySuggestion.layer.borderColor = MAIN_LINE_COLOR.CGColor;
        _mySuggestion.layer.borderWidth =1.0;
        _mySuggestion.layer.cornerRadius =5.0;
        _mySuggestion.font = H14;
    
    }
    return _mySuggestion;
}

-(UILabel *)suggest{
    if (!_suggest) {
        _suggest = [[UILabel alloc] init];
        _suggest.text = @"非常感谢你提供的宝贵意见,请重新注册登陆";
        _suggest.font = H14;
        _suggest.textColor = MAIN_PAN_2;
    }
    return _suggest;
}

-(UIButton *)addTo{
    if (!_addTo) {
        _addTo = [[UIButton alloc] init];
        [_addTo setTitle:@"追加提交" forState:UIControlStateNormal];
        _addTo.titleLabel.font = H22;
        [_addTo addTarget:self action:@selector(addTo:) forControlEvents:UIControlEventTouchUpInside];
        
        [_addTo.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_addTo.layer setCornerRadius:10];
        
        [_addTo.layer setBorderWidth:2];//设置边界的宽度
        
        [_addTo setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){242/255.f,130/255.f,74/255.f,1});
        
        [_addTo.layer setBorderColor:color];
    }
    return _addTo;
}

-(void)addTo:(UIButton *)button{

}

@end
