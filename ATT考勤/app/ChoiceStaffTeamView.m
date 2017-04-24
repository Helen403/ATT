//
//  ChoiceStaffView.m
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChoiceStaffTeamView.h"
#import "ChoiceStaffTeamViewModel.h"
#import "ChoiceStaffTeamCellView.h"

@interface ChoiceStaffTeamView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) ChoiceStaffTeamViewModel *choiceStaffTeamViewModel;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIImageView *cir;

@property(nonatomic,strong) UILabel *select;

@property(nonatomic,strong) UIView *selectView;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIView *bg;

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UIView *bottomView;

@property(nonatomic,strong) UIButton *sure;

@end

@implementation ChoiceStaffTeamView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.choiceStaffTeamViewModel = (ChoiceStaffTeamViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:10]);
    }];
    
//    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(0);
//        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:10]);
//        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:50]));
//    }];
//    
//    [self.cir mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(10);
//        make.centerY.equalTo(weakSelf.selectView);
//    }];
    
//    [self.select mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.title.mas_right).offset([self h_w:10]);
//        make.centerY.equalTo(weakSelf.selectView);
//    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH,(self.choiceStaffTeamViewModel.arr.count)*[self h_w:50]));
    }];
    
//    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.tableView.mas_bottom).offset([self h_w:30]);
//        make.centerX.equalTo(weakSelf);
//    }];
//    
//    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.icon.mas_bottom).offset([self h_w:10]);
//        make.centerX.equalTo(weakSelf);
//    }];
//    
//    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(0);
//        make.bottom.equalTo(0);
//        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:50]));
//    }];
//    
//    [self.sure mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(weakSelf.bottomView.mas_right).offset(-[self h_w:10]);
//        make.centerY.equalTo(weakSelf.bottomView);
//         make.size.equalTo(CGSizeMake([self h_w:65], [self h_w:30]));
//    }];
    
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    self.backgroundColor = GX_BGCOLOR;
    
    [self addSubview:self.title];
    [self addSubview:self.selectView];
    [self addSubview:self.cir];
    [self addSubview:self.select];
    [self addSubview:self.tableView];
    [self addSubview:self.bg];
    [self addSubview:self.icon];
    [self addSubview:self.name];
    [self addSubview:self.bottomView];
    [self addSubview:self.sure];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)h_loadData{
    NSString *companyCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.choiceStaffTeamViewModel.companyCode = companyCode;
    [self.choiceStaffTeamViewModel.refreshDataCommand execute:nil];
}

-(void)h_bindViewModel{
    
    [[self.choiceStaffTeamViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self  updateConstraints];
            
            [self.tableView reloadData];
            
        });
        
    }];
}


#pragma mark lazyload
-(ChoiceStaffTeamViewModel *)choiceStaffTeamViewModel{
    if (!_choiceStaffTeamViewModel) {
        _choiceStaffTeamViewModel = [[ChoiceStaffTeamViewModel alloc] init];
    }
    return _choiceStaffTeamViewModel;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"全公司";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UIImageView *)cir{
    if (!_cir) {
        _cir = [[UIImageView alloc] init];
        _cir.image = ImageNamed(@"abc_normal");
    }
    return _cir;
}

-(UILabel *)select{
    if (!_select) {
        _select = [[UILabel alloc] init];
        _select.text = @"全选";
        _select.font = H14;
        _select.textColor = MAIN_PAN_2;
    }
    return _select;
}

-(UIView *)selectView{
    if (!_selectView) {
        _selectView = [[UIView alloc] init];
        _selectView.backgroundColor = white_color;
    }
    return _selectView;
}

-(UIView *)bg{
    if (!_bg) {
        _bg = [[UIView alloc] init];
    }
    return _bg;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        //_icon.image = ImageNamed(@"guide_icon");
    }
    return _icon;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = white_color;
    }
    return _bottomView;
}

-(UIButton *)sure{
    if (!_sure) {
        _sure = [[UIButton alloc] init];
        [_sure setTitle:@" 确认 " forState:UIControlStateNormal];
        _sure.titleLabel.font = H14;
        [_sure addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        [_sure.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [_sure.layer setCornerRadius:10];
        [_sure.layer setBorderWidth:2];//设置边界的宽度
        [_sure setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色
        [_sure.layer setBorderColor:MAIN_ORANGER.CGColor];
    }
    return _sure;
}

-(void)sureClick:(UIButton *)button{
    
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        //_name.text = @"暂无员工";
        _name.font = H12;
        _name.textColor = MAIN_PAN_2;
    }
    return _name;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ChoiceStaffTeamCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ChoiceStaffTeamCellView class])]];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.choiceStaffTeamViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChoiceStaffTeamCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ChoiceStaffTeamCellView class])] forIndexPath:indexPath];
    
    cell.teamModel = self.choiceStaffTeamViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.choiceStaffTeamViewModel.cellclickSubject sendNext:row];
}

@end
