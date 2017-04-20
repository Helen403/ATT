//
//  ChoiceStaffView.m
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ChoiceStaffView.h"
#import "ChoiceStaffViewModel.h"
#import "ChoiceStaffCellView.h"
#import "TeamListModel.h"

@interface ChoiceStaffView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) ChoiceStaffViewModel *choiceStaffViewModel;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *titleTeam;

@property(nonatomic,strong) UIImageView *cir;

@property(nonatomic,strong) UILabel *select;

@property(nonatomic,strong) UIView *selectView;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIView *bg;

@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) UILabel *hintText;

@property(nonatomic,strong) UIView *bottomView;

@property(nonatomic,strong) UIButton *sure;

@property(nonatomic,assign) Boolean flag;

@end

@implementation ChoiceStaffView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.choiceStaffViewModel = (ChoiceStaffViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self h_w:10]);
        make.top.equalTo([self h_w:10]);
    }];
    
    [self.titleTeam mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.title.mas_right).offset([self h_w:10]);
        make.centerY.equalTo(weakSelf.title);
    }];
    
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:10]);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:50]));
    }];
    
    [self.cir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.equalTo(weakSelf.selectView);
    }];
    
    [self.select mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.cir.mas_right).offset([self h_w:10]);
        make.centerY.equalTo(weakSelf.selectView);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.selectView.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH,(self.choiceStaffViewModel.arr.count)*[self h_w:50]));
    }];
    
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tableView.mas_bottom).offset([self h_w:10]);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:50]));
    }];
    
    [self.hintText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.centerY.equalTo(weakSelf.bottomView);
    }];
    
    
    [self.sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bottomView.mas_right).offset(-[self h_w:10]);
        make.centerY.equalTo(weakSelf.bottomView);
        make.size.equalTo(CGSizeMake([self h_w:65], [self h_w:30]));
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = GX_BGCOLOR;
    
    [self addSubview:self.title];
    [self addSubview:self.titleTeam];
    [self addSubview:self.selectView];
    [self addSubview:self.cir];
    [self addSubview:self.select];
    [self addSubview:self.tableView];
    [self addSubview:self.bg];
    
    [self addSubview:self.name];
    
    
    [self addSubview:self.bottomView];
    [self addSubview:self.hintText];
    [self addSubview:self.sure];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)h_loadData{
    
    
}


//-(void)setTitleTeam:(UILabel *)titleTeam{
//     self.titleTeam.text = self.teamTitle;
//}

-(void)setTeamTitle:(NSString *)teamTitle{
    if (!teamTitle) {
        return;
    }
    _teamTitle = teamTitle;
    self.titleTeam.text = teamTitle;
    
}


-(void)h_bindViewModel{
    
    [[self.choiceStaffViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self updateConstraints];
            
            [self.tableView reloadData];
            self.name.text =[NSString stringWithFormat:@"共%lu人",(unsigned long)self.choiceStaffViewModel.arr.count];
        });
        
    }];
}


#pragma mark lazyload
-(ChoiceStaffViewModel *)choiceStaffViewModel{
    if (!_choiceStaffViewModel) {
        _choiceStaffViewModel = [[ChoiceStaffViewModel alloc] init];
    }
    return _choiceStaffViewModel;
}


-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"全公司 > ";
        _title.font = H14;
        _title.textColor = MAIN_PAN_2;
    }
    return _title;
}

-(UILabel *)titleTeam{
    if (!_titleTeam) {
        _titleTeam = [[UILabel alloc] init];
        _titleTeam.text = @"";
        _titleTeam.font = H14;
        _titleTeam.textColor = MAIN_PAN_2;
    }
    return _titleTeam;
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
        _selectView.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClick)];
        [_selectView addGestureRecognizer:setTap];
    }
    return _selectView;
}

-(void)selectClick{
    if (!self.flag) {
        self.cir.image = ImageNamed(@"abc_normal");
        self.flag = YES;
        [self.choiceStaffViewModel.selectorPatnArray removeAllObjects];
        for (int i = 0; i < self.choiceStaffViewModel.arr.count; i++) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:path];
            cell.selected = NO;
            
            [self.tableView deselectRowAtIndexPath:path animated:NO];
        }
    }else{
        self.cir.image = ImageNamed(@"abc_press");
        self.flag = NO;
        [self.choiceStaffViewModel.selectorPatnArray removeAllObjects];
        for (int i = 0; i < self.choiceStaffViewModel.arr.count; i++) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:path];
            cell.selected = YES;
            [self.choiceStaffViewModel.selectorPatnArray addObject:self.choiceStaffViewModel.arr[i]];//添加到选中列表
            
        }
    }
}


-(UIView *)bg{
    if (!_bg) {
        _bg = [[UIView alloc] init];
    }
    return _bg;
}


-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = white_color;
    }
    return _bottomView;
}

-(UILabel *)hintText{
    if (!_hintText) {
        _hintText = [[UILabel alloc] init];
        _hintText.text = @"请选择员工";
        _hintText.font = H14;
        _hintText.textColor = MAIN_PAN_2;
    }
    return _hintText;
    
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
    if (self.choiceStaffViewModel.selectorPatnArray.count > 0) {
        for(int i = 0;i<self.choiceStaffViewModel.selectorPatnArray.count;i++){
            
//            TeamListModel *teamListModel = self.choiceStaffViewModel.selectorPatnArray[i];
        }
        
        [self.choiceStaffViewModel.sendSubject sendNext:nil];
    }else{
        ShowMessage(@"请选择员工");
    }
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"暂无员工";
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
        [_tableView registerClass:[ChoiceStaffCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ChoiceStaffCellView class])]];
        _tableView.editing = YES;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.choiceStaffViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChoiceStaffCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ChoiceStaffCellView class])] forIndexPath:indexPath];
    
    cell.teamListModel = self.choiceStaffViewModel.arr[indexPath.row];
   
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //选中数据
    [self.choiceStaffViewModel.selectorPatnArray addObject:self.choiceStaffViewModel.arr[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //从选中中取消
    if (self.choiceStaffViewModel.selectorPatnArray.count > 0) {
        
        [self.choiceStaffViewModel.selectorPatnArray removeObject:self.choiceStaffViewModel.arr[indexPath.row]];
    }
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


@end
