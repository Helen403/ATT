//
//  FunctionView.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "FunctionView.h"
#import "FunctionViewModel.h"


@interface FunctionView()

@property(nonatomic,strong) FunctionViewModel *functionViewModel;

@property(nonatomic,strong) UIWebView *webView;

@end

@implementation FunctionView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.functionViewModel = (FunctionViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.webView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        //_webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
        NSURL* url = [NSURL URLWithString:funcaa1];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [_webView loadRequest:request];//加载
    }
    return _webView;
}



@end
