//
//  BuildRoleView.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "BuildRoleView.h"
#import "BuildRoleViewModel.h"

@interface BuildRoleView()

@property(nonatomic,strong) BuildRoleViewModel *buildRoleViewModel;

@property(nonatomic,strong) UIImageView *twoDimensionCodeImg;

@property(nonatomic,strong) UILabel *twoDimensionCodeTitle;

@property(nonatomic,strong) UILabel *twoDimensionCodeText;

@property(nonatomic,strong) UIImageView *twoDimensionCodeBack;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIImageView *companyImg;

@property(nonatomic,strong) UILabel *companyTitle;

@property(nonatomic,strong) UILabel *companyText;

@property(nonatomic,strong) UIImageView *companyBack;

@property(nonatomic,strong) UIView *line2;

@end
@implementation BuildRoleView

-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.buildRoleViewModel = (BuildRoleViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}


#pragma mark system
-(void)updateConstraints{
    
    WS(weakSelf);
    CGFloat leftPadding =(SCREEN_WIDTH-SCREEN_WIDTH*0.8)*0.5;
    CGFloat topPadding = SCREEN_HEIGHT *0.1;
    
    [self.twoDimensionCodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topPadding);
        make.left.equalTo(leftPadding);
    }];
    
    
    [self.twoDimensionCodeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.twoDimensionCodeImg);
        make.left.equalTo(weakSelf.twoDimensionCodeImg.mas_right).offset(10);
        
    }];
    
    [self.twoDimensionCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.twoDimensionCodeTitle.mas_bottom).offset(7);
        make.left.equalTo(weakSelf.twoDimensionCodeTitle);
    }];
    
    [self.twoDimensionCodeBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.twoDimensionCodeImg);
        make.right.equalTo(-leftPadding);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding*2,1));
        make.right.equalTo(-leftPadding);
        make.top.equalTo(weakSelf.twoDimensionCodeText.mas_bottom).offset(20);
    }];
    
    [self.companyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.twoDimensionCodeImg);
        make.top.equalTo(weakSelf.line1.mas_bottom).offset(15);
    }];
    
    
    [self.companyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.companyImg);
        make.left.equalTo(weakSelf.companyImg.mas_right).offset(10);
    }];
    
    [self.companyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.companyTitle.mas_bottom).offset(7);
        make.left.equalTo(weakSelf.companyTitle);
    }];
    
    [self.companyBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.companyImg);
        make.right.equalTo(-leftPadding);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH-leftPadding*2,1));
        make.right.equalTo(-leftPadding);
        make.top.equalTo(weakSelf.companyText.mas_bottom).offset(20);
    }];
    
    

    
    
    
    [super updateConstraints];
}

#pragma mark private;
-(void)h_setupViews{
    
    [self addSubview:self.twoDimensionCodeImg];
    [self addSubview:self.twoDimensionCodeTitle];
    [self addSubview:self.twoDimensionCodeText];
    [self addSubview:self.twoDimensionCodeBack];
    [self addSubview:self.line1];
    [self addSubview:self.companyImg];
    [self addSubview:self.companyTitle];
    [self addSubview:self.companyText];
    [self addSubview:self.companyBack];
    [self addSubview:self.line2];
  
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}


-(void)h_bindViewModel{
    
    
}


#pragma mark lazyload
-(BuildRoleViewModel *)buildRoleViewModel{
    if (!_buildRoleViewModel) {
        _buildRoleViewModel = [[BuildRoleViewModel alloc] init];
    }
    return _buildRoleViewModel;
    
}
-(UIImageView *)twoDimensionCodeImg{
    if (!_twoDimensionCodeImg) {
        _twoDimensionCodeImg = [[UIImageView alloc] init];
        _twoDimensionCodeImg.image = ImageNamed(@"role_two_icon");
    }
    return _twoDimensionCodeImg;
}

-(UILabel *)twoDimensionCodeTitle{
    if (!_twoDimensionCodeTitle) {
        _twoDimensionCodeTitle = [[UILabel alloc] init];
        _twoDimensionCodeTitle.text = @"扫码加入";
        _twoDimensionCodeTitle.font = H18;
    }
    return _twoDimensionCodeTitle;
    
}

-(UILabel *)twoDimensionCodeText{
    if (!_twoDimensionCodeText) {
        _twoDimensionCodeText = [[UILabel alloc] init];
        _twoDimensionCodeText.text = @"扫描公司提供的二维码";
        _twoDimensionCodeText.textColor = MAIN_PAN;
        _twoDimensionCodeText.font = H14;
    }
    return _twoDimensionCodeText;
    
}


-(UIImageView *)twoDimensionCodeBack{
    if (!_twoDimensionCodeBack) {
        _twoDimensionCodeBack = [[UIImageView alloc] init];
        _twoDimensionCodeBack.image = ImageNamed(@"role_right_arrow");
        _twoDimensionCodeBack.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoDimensionCode)];
        [_twoDimensionCodeBack addGestureRecognizer:setTap];
    }
    return _twoDimensionCodeBack;
}
-(void)twoDimensionCode{


}

-(UIView *)line1{
    if (!_line1) {
        _line1  = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_GRAY;
    }
    return _line1;
}

-(UIImageView *)companyImg{
    if (!_companyImg) {
        _companyImg = [[UIImageView alloc] init];
        _companyImg.image = ImageNamed(@"role_code_icon");
        _companyImg.userInteractionEnabled = YES;
    }
    return _companyImg;
}


-(UILabel *)companyTitle {
    if (!_companyTitle) {
        _companyTitle = [[UILabel alloc] init];
        _companyTitle.text = @"企业码加入";
        _companyTitle.font = H18;
    }
    return _companyTitle;
}

-(UILabel *)companyText{
    if (!_companyText) {
        _companyText = [[UILabel alloc] init];
         _companyText.text = @"输入公司提供的企业邀请码";
        _companyText.textColor = MAIN_PAN;
             _companyText.font = H14;
    }
    return _companyText;
}
-(UIImageView *)companyBack{
    if (!_companyBack) {
        _companyBack = [[UIImageView alloc] init];
        _companyBack.image = ImageNamed(@"role_right_arrow");
        _companyBack.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(companyCode)];
        [_companyBack addGestureRecognizer:setTap];
    }
    return _companyBack;
}

-(void)companyCode{

    [self.buildRoleViewModel.companyCodeclickSubject sendNext:nil];
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_GRAY;
    }
    return _line2;
    
}


@end
