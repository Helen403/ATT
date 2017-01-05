//
//  CompanyCodeView.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "CompanyCodeView.h"
#import "CompanyCodeViewModel.h"

@interface CompanyCodeView()

@property(nonatomic,strong) CompanyCodeViewModel *companyCodeViewModel;

@property(nonatomic,strong) UIImageView *companyCodeImg;

@property(nonatomic,strong) UITextField *companyCodeTextField;

@property(nonatomic,strong) UILabel *hintText;

@property(nonatomic,strong) UIButton *addBtn;

@end

@implementation CompanyCodeView
#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    
    self.companyCodeViewModel = (CompanyCodeViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
    
}

-(void)updateConstraints{
    
    WS(weakSelf);
    CGFloat leftPadding =(SCREEN_WIDTH-SCREEN_WIDTH*0.8)*0.5;
    CGFloat topPadding = SCREEN_HEIGHT *0.1;
    
    [self.companyCodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topPadding);
        make.left.equalTo(leftPadding);
    }];
    
    
    [self.companyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.companyCodeImg.mas_right).offset([self h_w:10]);
        make.centerY.equalTo(weakSelf.companyCodeImg);
    }];
    
    
    [self.hintText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.companyCodeImg);
        make.top.equalTo(weakSelf.companyCodeImg.mas_bottom).offset([self h_w:15]);
        
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hintText.mas_bottom).offset([self h_w:15]);
        make.left.equalTo(leftPadding);
        make.right.equalTo(-leftPadding);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:40]));
    }];
    
    
    [super updateConstraints];
    
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.companyCodeImg];
    [self addSubview:self.companyCodeTextField];
    [self addSubview:self.hintText];
    [self addSubview:self.addBtn];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    
    
}

#pragma mark lazyload
-(CompanyCodeViewModel *)companyCodeViewModel{
    if (!_companyCodeViewModel) {
        _companyCodeViewModel = [[CompanyCodeViewModel alloc] init];
    }
    return _companyCodeViewModel;
    
}


-(UIImageView *)companyCodeImg{
    if (!_companyCodeImg) {
        _companyCodeImg = [[UIImageView alloc] init];
        _companyCodeImg.image = ImageNamed(@"role_code_icon");
        
    }
    return _companyCodeImg;
    
}

-(UITextField *)companyCodeTextField{
    if (!_companyCodeTextField) {
        _companyCodeTextField = [[UITextField alloc] init];
        
        _companyCodeTextField.backgroundColor = [UIColor clearColor];
        //设置边框样式，只有设置了才会显示边框样式
        
        // 设置内容 -- 垂直居中
        _companyCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //当输入框没有内容时，水印提示 提示内容为password
        _companyCodeTextField.placeholder = @"输入公司码";
        
        //修改account的placeholder的字体颜色、大小
        [_companyCodeTextField setValue: [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        [_companyCodeTextField setValue:H14 forKeyPath:@"_placeholderLabel.font"];
        //设置输入框内容的字体样式和大小
        _companyCodeTextField.font = H14;
        // 设置右边永远显示清除按钮
        _companyCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _companyCodeTextField;
}

-(UILabel *)hintText{
    if (!_hintText) {
        _hintText = [[UILabel alloc] init];
        _hintText.textColor = MAIN_PAN;
        _hintText.text = @"联系公司管理获取公司码";
        _hintText.font = H14;
    }
    return _hintText;
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        
        
        [_addBtn setTitle:@"加   入" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = H22;
        [_addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
        
        [_addBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_addBtn.layer setCornerRadius:10];
        
        [_addBtn.layer setBorderWidth:2];//设置边界的宽度
        
        [_addBtn setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){242/255.f,130/255.f,74/255.f,1});
        
        [_addBtn.layer setBorderColor:color];
    }
    return _addBtn;
    
}


-(void)add:(UIButton *)button{

    [self.companyCodeViewModel.addclickSubject sendNext:nil];
}

@end
