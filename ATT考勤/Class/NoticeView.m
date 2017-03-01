//
//  NoticeView.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "NoticeView.h"
#import "NoticeViewModel.h"
#import "AnnouncementModel.h"

@interface NoticeView()

@property(nonatomic,strong) NoticeViewModel *noticeViewModel;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *content;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UIButton *preBtn;

@property(nonatomic,strong) UILabel *page;

@property(nonatomic,strong) UIButton *lastBtn;

@property(nonatomic,assign) NSInteger index;


@end

@implementation NoticeView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.noticeViewModel = (NoticeViewModel *)viewModel;
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

-(void)h_loadData{
    
    self.index = 1;
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.noticeViewModel.companyCode = companyCode;
    
    [self.noticeViewModel.refreshDataCommand execute:nil];
    
}

-(void)h_refreash{
    self.index = 1;
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.noticeViewModel.companyCode = companyCode;
    
    [self.noticeViewModel.refreshDataCommand execute:nil];
}


-(void)h_bindViewModel{

    [[self.noticeViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {

         [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
    }];
}

-(void)mainThread{
    //设置多少页


    self.page.text = [NSString stringWithFormat:@"第1页/共%ld页",self.noticeViewModel.arr.count];
    AnnouncementModel *announcementModel = self.noticeViewModel.arr[0];
    self.title.text = announcementModel.msgSubject;
    self.content.text = announcementModel.msgContent;
    self.name.text =  announcementModel.msgSenderName;
    self.time.text = announcementModel.msgPublishDate;
}

#pragma mark lazyload
-(NoticeViewModel *)noticeViewModel{
    if (!_noticeViewModel) {
        _noticeViewModel = [[NoticeViewModel alloc] init];
    }
    return _noticeViewModel;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"";
        _title.font = H26;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.text = @"";
        _content.font = H18;
        _content.textColor = MAIN_PAN_2;
        //自动折行设置
        [_content setLineBreakMode:NSLineBreakByWordWrapping];
        _content.numberOfLines = 0;
    }
    return _content;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"";
        _name.font = H18;
        _name.textColor = MAIN_PAN_2;
    }
    return _name;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"";
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
    self.index--;
    if (self.index == 0) {
        self.index = 1;
    }

    self.page.text = [NSString stringWithFormat:@"第%ld页/共%ld页",(long)self.index,self.noticeViewModel.arr.count];
    AnnouncementModel *announcementModel = self.noticeViewModel.arr[self.index-1];
    self.title.text = announcementModel.msgSubject;
    self.content.text = announcementModel.msgContent;
    self.name.text =  announcementModel.msgSenderName;
    self.time.text = announcementModel.msgPublishDate;
}

-(UILabel *)page{
    if (!_page) {
        _page = [[UILabel alloc] init];
        _page.text = @"";
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
    
    self.index++;
    if (self.index > self.noticeViewModel.arr.count) {
        self.index = self.noticeViewModel.arr.count;
    }
    
    self.page.text = [NSString stringWithFormat:@"第%ld页/共%ld页",(long)self.index,self.noticeViewModel.arr.count];
    AnnouncementModel *announcementModel = self.noticeViewModel.arr[self.index-1];
    self.title.text = announcementModel.msgSubject;
    self.content.text = announcementModel.msgContent;
    self.name.text =  announcementModel.msgSenderName;
    self.time.text = announcementModel.msgPublishDate;

}


@end
