//
//  InformView.m
//  ATT考勤
//
//  Created by Helen on 17/1/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "InformView.h"
#import "InformViewModel.h"

@interface InformView()

@property(nonatomic,strong) InformViewModel *informViewModel;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *content;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UIButton *preBtn;

@property(nonatomic,strong) UILabel *page;

@property(nonatomic,strong) UIButton *lastBtn;

@end

@implementation InformView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.informViewModel = (InformViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([self h_w:10]);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.right.equalTo(-[self h_w:10]);
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:15]);
        // make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:130]));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-[self h_w:10]);
        make.top.equalTo(weakSelf.content.mas_bottom).offset([self h_w:30]);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-[self h_w:10]);
        make.top.equalTo(weakSelf.name.mas_bottom).offset([self h_w:10]);
    }];
    
    
    [self.preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(-[self h_w:10]);
        make.left.equalTo(weakSelf).offset([self h_w:10]);
    }];
    
    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.preBtn);
    }];
    
    [self.lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.preBtn);
        make.right.equalTo(-[self h_w:10]);
        
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.title];
    [self addSubview:self.content];
    [self addSubview:self.name];
    [self addSubview:self.time];
    [self addSubview:self.preBtn];
    [self addSubview:self.page];
    [self addSubview:self.lastBtn];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(InformViewModel *)informViewModel{
    if (!_informViewModel) {
        _informViewModel = [[InformViewModel alloc] init];
    }
    return _informViewModel;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"关于2017年春节放假通知";
        _title.font = H26;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.text = @"各位同事:\n    根据国务院办公厅通知精神，现将2017年春节放假通知如下:1月25日至2月4日放假调休，共10天。1月22日(星期日),2月5日(星期日)上班。\n    请各位同事注意安全，确保大家祥和平安度过节日假期。\n    提前祝大家春节愉快！";
        _content.font = H18;
        _content.textColor = MAIN_PAN_2;
        //自动折行设置
        _content.lineBreakMode = NSLineBreakByWordWrapping;
        
        _content.numberOfLines = 0;
    }
    return _content;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"经理办公室";
        _name.font = H18;
        _name.textColor = MAIN_PAN_2;
    }
    return _name;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"2016年12月25日";
        _time.font = H18;
        _time.textColor = MAIN_PAN_2;
    }
    return _time;
}

-(UIButton *)preBtn{
    if (!_preBtn) {
        _preBtn = [[UIButton alloc] init];
        [_preBtn setTitle:@" 上一页 " forState:UIControlStateNormal];
        _preBtn.titleLabel.font = H14;
        [_preBtn addTarget:self action:@selector(pre:) forControlEvents:UIControlEventTouchUpInside];
        
        [_preBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_preBtn.layer setCornerRadius:10];
        
        [_preBtn.layer setBorderWidth:2];//设置边界的宽度
        
        [_preBtn setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色

        [_preBtn.layer setBorderColor:MAIN_ORANGER.CGColor];
        
    }
    return _preBtn;
}

-(void)pre:(UIButton *)button{
    ShowMessage(@"暂时没内容 上一页");
    
}

-(UILabel *)page{
    if (!_page) {
        _page = [[UILabel alloc] init];
        _page.text = @"第1页/共3页";
        _page.font = H14;
        _page.textColor = MAIN_PAN_2;
    }
    return _page;
}

-(UIButton *)lastBtn{
    if (!_lastBtn) {
        _lastBtn = [[UIButton alloc] init];
        [_lastBtn setTitle:@" 下一页 " forState:UIControlStateNormal];
        _lastBtn.titleLabel.font = H14;
        [_lastBtn addTarget:self action:@selector(last:) forControlEvents:UIControlEventTouchUpInside];
        
        [_lastBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_lastBtn.layer setCornerRadius:10];
        
        [_lastBtn.layer setBorderWidth:2];//设置边界的宽度
        
        [_lastBtn setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
   
        
        [_lastBtn.layer setBorderColor:MAIN_ORANGER.CGColor];
        
    }
    return _lastBtn;
}

-(void)last:(UIButton *)button{
    ShowMessage(@"暂时没内容 下一页");
    
}
@end
