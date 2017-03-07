//
//  CompanyCodeView.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "CompanyCodeView.h"
#import "CompanyCodeViewModel.h"
#import "CompanyCodeCellView.h"

@interface CompanyCodeView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) CompanyCodeViewModel *companyCodeViewModel;

@property(nonatomic,strong) UIImageView *companyCodeImg;

@property(nonatomic,strong) UITextField *companyCodeTextField;

@property(nonatomic,strong) UILabel *hintText;

@property(nonatomic,strong) UIButton *addBtn;

@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UITableView *tableView;

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
    CGFloat topPadding = SCREEN_HEIGHT *0.05;
    CGFloat length = SCREEN_WIDTH-SCREEN_WIDTH*0.35;
    
    [self.companyCodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topPadding);
        make.left.equalTo(leftPadding);
    }];
    
    
    [self.companyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.companyCodeImg.mas_right).offset([self h_w:10]);
        make.centerY.equalTo(weakSelf.companyCodeImg);
        
        make.size.equalTo(CGSizeMake(length, [self h_w:30]));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPadding);
        make.right.equalTo(-leftPadding);
        make.top.equalTo(weakSelf.companyCodeImg.mas_bottom).offset([self h_w:3]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.hintText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.companyCodeImg);
        make.top.equalTo(weakSelf.companyCodeImg.mas_bottom).offset([self h_w:15]);
        
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hintText.mas_bottom).offset([self h_w:15]);
        make.left.equalTo(leftPadding);
        make.right.equalTo(-leftPadding);
        
    }];
    
    
    [super updateConstraints];
    
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.companyCodeImg];
    [self addSubview:self.companyCodeTextField];
    [self addSubview:self.hintText];
    [self addSubview:self.addBtn];
    [self addSubview:self.line];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
   
    
    //加入公司后弹出部门选择
    [[self.companyCodeViewModel.showClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
    }];
    
    
    [[self.companyCodeViewModel.failclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        [self performSelectorOnMainThread:@selector(failBack) withObject:nil waitUntilDone:YES];
    }];
    
}

-(void)failBack{
    ShowErrorStatus(@"公司邀请码不正确");
    self.companyCodeTextField.text = @"";
    self.addBtn.enabled = YES;
    [self.addBtn setBackgroundColor:MAIN_ORANGER];
    //设置按钮的边界颜色
    
    [self.addBtn.layer setBorderColor:MAIN_ORANGER.CGColor];
}

-(void)mainThread{
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.8, (self.companyCodeViewModel.arr.count+1)*[self h_w:40]);
    [self.tableView reloadData];
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
    [HWPopTool sharedInstance].tapOutsideToDismiss = NO;
    [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
    [[HWPopTool sharedInstance] showWithPresentView:self.tableView animated:NO];
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
        [_companyCodeTextField setValue: MAIN_TEXTFIELD forKeyPath:@"_placeholderLabel.textColor"];
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
        _hintText.font = H10;
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
        
        [_addBtn.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    return _addBtn;
    
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line;
    
}

-(void)add:(UIButton *)button{
    if (self.companyCodeTextField.text.length>0) {
        NSString *str =  [[NSUserDefaults standardUserDefaults] objectForKey:@"createUserCode"];
        self.companyCodeViewModel.userCode = str;
        self.companyCodeViewModel.invitationCode = self.companyCodeTextField.text;
        [self.companyCodeViewModel.sendclickCommand execute:nil];
        self.addBtn.enabled = NO;
        [_addBtn setBackgroundColor:MAIN_ENABLE];
        //设置按钮的边界颜色
        
        [_addBtn.layer setBorderColor:MAIN_ENABLE.CGColor];
        
    }else{
        
        ShowErrorStatus(@"请输入公司码");
        self.addBtn.enabled = YES;
        [self.addBtn setBackgroundColor:MAIN_ENABLE];
        //设置按钮的边界颜色
        
        [self.addBtn.layer setBorderColor:MAIN_ENABLE.CGColor];
    }
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[CompanyCodeCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyCodeCellView class])]];
        _tableView.scrollEnabled = NO;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.8, [self h_w:40])];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, [self h_w:120], [self h_w:40]);
        //        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"公司部门";
        label.textColor = MAIN_PAN_2;
        label.font = H14;
        label.center = CGPointMake([self h_w:60], [self h_w:20]);
        [view addSubview:label];
        _tableView.tableHeaderView = view;
        
    }
    return _tableView;
    
}

#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.companyCodeViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyCodeCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyCodeCellView class])] forIndexPath:indexPath];
    
    cell.teamModel = self.companyCodeViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeamModel *teamModel =  self.companyCodeViewModel.arr[indexPath.row];
    self.companyCodeViewModel.deptCode = teamModel.deptCode;
    [self.companyCodeViewModel.addTeamCommand execute:nil];
    [[HWPopTool sharedInstance] closeWithBlcok:^{
        
    }];
}

@end
