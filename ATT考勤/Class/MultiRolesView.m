//
//  MultiRolesView.m
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MultiRolesView.h"
#import "MultiRolesViewModel.h"
#import "MultiRolesCellView.h"
#import "UserModel.h"


@interface MultiRolesView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) MultiRolesViewModel *multiRolesViewModel;

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UIImageView *bg;

@property(nonatomic,strong) UIImageView *add;

@end

@implementation MultiRolesView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.multiRolesViewModel = (MultiRolesViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo([self h_w:30]);
        make.size.equalTo(CGSizeMake([self h_w:85], [self h_w:85]));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.icon);
    }];
    
    [self.add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset([self h_w:-15]);
        make.top.equalTo(weakSelf.icon);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.icon.mas_bottom).offset([self h_w:10]);
        //        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.bg];
    [self addSubview:self.icon];
    [self addSubview:self.title];
    [self addSubview:self.add];
    
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
 
}

-(void)h_loadData{
    UserModel *user = getModel(@"user");
    self.multiRolesViewModel.userCode = user.userCode;
    [self.multiRolesViewModel.refreshDataCommand execute:nil];
}


-(void)h_bindViewModel{
    //网络数据返回
    [[self.multiRolesViewModel.backSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *x) {
        
        [self performSelectorOnMainThread:@selector(reload) withObject:nil waitUntilDone:YES];
    }];
}

-(void)reload{
    [self.tableView reloadData];
}

#pragma mark lazyload
-(MultiRolesViewModel *)multiRolesViewModel{
    if (!_multiRolesViewModel) {
        _multiRolesViewModel = [[MultiRolesViewModel alloc] init];
    }
    return _multiRolesViewModel;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = ImageNamed(@"switch_role_refresh");
        _icon.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
        [_icon addGestureRecognizer:setTap];
    }
    return _icon;
}

-(void)click{
    
    UserModel *user = getModel(@"user");
    self.multiRolesViewModel.userCode = user.userCode;
    [self.multiRolesViewModel.refreshDataCommand execute:nil];
}


-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"刷新角色";
        _title.font = H16;
        _title.textColor = white_color;
    }
    return _title;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MultiRolesCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MultiRolesCellView class])]];
        _tableView.scrollEnabled = NO;
        
        //        WS(weakSelf)
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //
        //           // [weakSelf.multiRolesViewModel.refreshDataCommand execute:nil];
        //        }];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.multiRolesViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MultiRolesCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MultiRolesCellView class])] forIndexPath:indexPath];
    
    cell.multiRolesModel = self.multiRolesViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MultiRolesModel *multiRoleModel = self.multiRolesViewModel.arr[indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:multiRoleModel.companyCode forKey:@"companyCode"];
    [[NSUserDefaults standardUserDefaults] setObject:multiRoleModel.companyFullName forKey:@"companyFullName"];
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.multiRolesViewModel.cellclickSubject sendNext:row];
    
}

-(UIImageView *)add{
    if (!_add) {
        _add = [[UIImageView alloc] init];
        _add.image = ImageNamed(@"switch_role_add_gray");
        _add.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addCompany)];
        [_add addGestureRecognizer:setTap];
    }
    return _add;
}

-(void)addCompany{
    [self.multiRolesViewModel.addSubject sendNext:nil];
    
}

-(UIImageView *)bg{
    if (!_bg) {
        _bg = [[UIImageView alloc] init];
        //        _bg.image = ImageNamedBg;
    }
    return _bg;
}


@end
