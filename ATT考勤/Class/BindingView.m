//
//  BindingView.m
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "BindingView.h"
#import "BindingViewModel.h"
#import "UserModel.h"

@interface BindingView()

@property(nonatomic,strong) BindingViewModel *bindingViewModel;

@property(nonatomic,strong) UILabel *lateName;

@property(nonatomic,strong) UILabel *lateEquipment;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UILabel *preName;

@property(nonatomic,strong) UILabel *preEquipment;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIButton *bind;

@end


@implementation BindingView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.bindingViewModel = (BindingViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.lateEquipment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:15]);
        make.top.equalTo([self h_w:15]);
    }];
    
    [self.lateName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lateEquipment.mas_right).offset([self h_w:10]);
          make.top.equalTo(weakSelf.lateEquipment);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(weakSelf.lateEquipment.mas_bottom).offset([self h_w:15]);
          make.left.equalTo(0);
         make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.preEquipment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lateEquipment);
        make.top.equalTo(weakSelf.line1.mas_bottom).offset([self h_w:15]);
    }];
    
    [self.preName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.preEquipment.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.preEquipment);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.preEquipment.mas_bottom).offset([self h_w:15]);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    [self.bind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line2.mas_bottom).offset([self h_w:15]);
        make.left.equalTo([self h_w:15]);
        make.right.equalTo(weakSelf.mas_right).offset(-[self h_w:10]);
    }];
    
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    
    [self addSubview:self.lateName];
    [self addSubview:self.lateEquipment];
    [self addSubview:self.preName];
    [self addSubview:self.preEquipment];
    [self addSubview:self.line1];
    [self addSubview:self.line2];
    [self addSubview:self.bind];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [[self.bindingViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.lateName.text = self.bindingViewModel.deviceName;
            self.preName.text = [LSCoreToolCenter deviceVersion];
        });

    }];
}

-(void)h_loadData{
    UserModel *user =  getModel(@"user");
    self.bindingViewModel.userCode = user.userCode;
    [self.bindingViewModel.refreshDataCommand execute:nil];
}

#pragma mark lazyload
-(BindingViewModel *)bindingViewModel{
    if (!_bindingViewModel) {
        _bindingViewModel = [[BindingViewModel alloc] init];
    }
    return _bindingViewModel;
}


-(UILabel *)lateName{
    if (!_lateName) {
        _lateName = [[UILabel alloc] init];
        _lateName.text = @"";
        _lateName.font = H14;
        _lateName.textColor = MAIN_PAN_2;
    }
    return _lateName;
}

-(UILabel *)lateEquipment{
    if (!_lateEquipment) {
        _lateEquipment = [[UILabel alloc] init];
        _lateEquipment.text = @"旧设备名称:";
        _lateEquipment.font = H14;
        _lateEquipment.textColor = MAIN_PAN_2;
    }
    return _lateEquipment;
}

-(UILabel *)preName{
    if (!_preName) {
        _preName = [[UILabel alloc] init];
        _preName.text = @"";
        _preName.font = H14;
        _preName.textColor = MAIN_PAN_2;
    }
    return _preName;
}

-(UILabel *)preEquipment{
    if (!_preEquipment) {
        _preEquipment = [[UILabel alloc] init];
        _preEquipment.text = @"新设备名称:";
        _preEquipment.font = H14;
        _preEquipment.textColor = MAIN_PAN_2;
    }
    return _preEquipment;
}

-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line1;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line2;
}

-(UIButton *)bind{
    if (!_bind) {
        _bind = [[UIButton alloc] init];
        [_bind setTitle:@"绑 定" forState:UIControlStateNormal];
        _bind.titleLabel.font = H22;
        [_bind addTarget:self action:@selector(bindClick) forControlEvents:UIControlEventTouchUpInside];
        [_bind.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [_bind.layer setCornerRadius:10];
        [_bind.layer setBorderWidth:2];//设置边界的宽度
        [_bind setBackgroundColor:MAIN_ORANGER];
        [_bind.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    return _bind;
}

-(void)bindClick{
    UserModel *user =  getModel(@"user");
    self.bindingViewModel.userCode = user.userCode;
    self.bindingViewModel.deviceCode = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    self.bindingViewModel.changeDeviceName = self.preName.text;
    
    [self.bindingViewModel.modifyCommand execute:nil];
}


@end
