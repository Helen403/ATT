//
//  CustomView.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CustomView.h"
#import "CustomViewModel.h"
#import "CustomCellView.h"
#import "CustomModel.h"


@interface CustomView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) CustomViewModel *customViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIWebView *webView;

@end

@implementation CustomView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.customViewModel = (CustomViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 4*[self h_w:50]));
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tableView.mas_bottom).offset(0);
        make.right.equalTo(0);
        make.left.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.tableView];
    [self addSubview:self.webView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[CustomCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CustomCellView class])]];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else {
        return 0;
    }
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CustomCellView class])] forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.customModel = self.customViewModel.arr[indexPath.row];
    }else{
        // cell.customModel = self.customViewModel.arr[indexPath.row+2];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.customViewModel.cellclickSubject sendNext:row];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self h_w:50];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = BG_COLOR;
    UILabel *text = [[UILabel alloc] init];
    
    text.font = H14;
    text.textColor = MAIN_PAN_2;
    if (section == 0) {
        text.text = @"在线客服";
    }else{
        text.text = @"常见问题";
    }
    text.frame = CGRectMake([self h_w:10], 0, SCREEN_WIDTH, [self h_w:50]);
    [headView addSubview:text];
    return headView;
}


#pragma mark lazyload
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        //_webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
        NSURL* url = [NSURL URLWithString:faqaa1];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [_webView loadRequest:request];//加载
    }
    return _webView;
}




@end
