//
//  AgreementController.m
//  ATT考勤
//
//  Created by Helen on 17/3/31.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AgreementController.h"

@interface AgreementController ()

@property(nonatomic,strong) UIWebView *webView;

@end

@implementation AgreementController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.webView];
}

-(void)h_layoutNavigation{
    self.title = @"产品协议";
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        //_webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
        NSURL* url = [NSURL URLWithString:AgreementLine];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [_webView loadRequest:request];//加载
    }
    return _webView;
}

@end
