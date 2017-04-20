//
//  CommunicationView.m
//  ATT考勤
//
//  Created by Helen on 17/4/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CommunicationView.h"
#import "CommunicationViewModel.h"
#import "CommunicationCellView.h"
#import "ComSearchView.h"


@interface CommunicationView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) CommunicationViewModel *communicationViewModel;

@property (nonatomic ,strong) ComSearchView *searchBar;

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *companyTitle;

@property(nonatomic,strong) UILabel *content;

@property(nonatomic,strong) UIImageView *back1;

@property(nonatomic,strong) UIView *line1;

@property(nonatomic,strong) UIView *view1;


@property(nonatomic,strong) UIImageView *myIcon;

@property(nonatomic,strong) UILabel *myTitle;

@property(nonatomic,strong) UILabel *myContent;

@property(nonatomic,strong) UIImageView *back2;

@property(nonatomic,strong) UIView *line2;

@property(nonatomic,strong) UIView *view2;

@property(nonatomic,strong) UILabel *collection;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIImageView *noPerson;

@property(nonatomic,strong) UILabel *noTitle;


@end

@implementation CommunicationView


#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.communicationViewModel = (CommunicationViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
    }];
    
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(weakSelf.searchBar.mas_bottom).offset(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:60]));
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view1);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.companyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.icon).offset([self h_w:2]);
        make.left.equalTo(weakSelf.icon.mas_right).offset([self h_w:10]);
    }];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.companyTitle.mas_bottom).offset([self h_w:6]);
        make.left.equalTo(weakSelf.icon.mas_right).offset([self h_w:10]);
    }];
    [self.back1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view1);
        make.right.equalTo(weakSelf.view1.mas_right).offset(-[self h_w:10]);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view1.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(weakSelf.view1.mas_bottom).offset(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:60]));
    }];
    
    [self.myIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view2);
        make.left.equalTo([self h_w:20]);
    }];
    
    [self.myTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.myIcon.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.myIcon.mas_top).offset([self h_w:2]);
    }];
    
    [self.myContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.myIcon.mas_right).offset([self h_w:10]);
        make.top.equalTo(weakSelf.myTitle.mas_bottom).offset([self h_w:6]);
    }];
    [self.back2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view2);
        make.right.equalTo(weakSelf.view2.mas_right).offset(-[self h_w:10]);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view2.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, [self h_w:1]));
    }];
    
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view2.mas_bottom).offset([self h_w:10]);
        make.left.equalTo([self h_w:10]);
    }];
    
    [self.noPerson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.collection.mas_bottom).offset([self h_w:110]);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.noTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.noPerson.mas_bottom).offset([self h_w:10]);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.collection.mas_bottom).offset([self h_w:10]);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = BG_COLOR;
    
    [self addSubview:self.searchBar];
    [self addSubview:self.view1];
    
    [self.view1 addSubview:self.icon];
    [self.view1 addSubview:self.companyTitle];
    [self.view1 addSubview:self.content];
    [self.view1 addSubview:self.back1];
    [self.view1 addSubview:self.line1];

    [self addSubview:self.view2];
    
    [self.view2 addSubview:self.myIcon];
    [self.view2 addSubview:self.myContent];
    [self.view2 addSubview:self.myTitle];
    [self.view2 addSubview:self.back2];
    [self.view2 addSubview:self.line2];
    
    [self addSubview:self.collection];
   
    [self addSubview:self.tableView];
    [self addSubview:self.noPerson];
    [self addSubview:self.noTitle];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [self.tableView addGestureRecognizer:longPressGr];

    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:self.tableView];
        
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
        
        if(indexPath == nil) return ;
        
        //add your code here
        
        NSLog(@"点击%ld",(long)indexPath.row);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除" message:@"确认要删除该收藏人" preferredStyle:UIAlertControllerStyleAlert];
        
        // 添加按钮
        __weak typeof(alert) weakAlert = alert;
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //NSLog(@"点击了取消按钮");
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            //NSLog(@"点击了确定按钮-");
            NSString *empCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"empCode"];
            self.communicationViewModel.myEmpCode = empCode;
            NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
            self.communicationViewModel.companyCode = companyCode;
            CommunicationModel *model = self.communicationViewModel.arr[indexPath.row];
            self.communicationViewModel.friendEmpCode = model.empCode;
            [self.communicationViewModel.delCommand execute:nil];
            [self.communicationViewModel.arr removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }]];
       

        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
        
        [nav presentViewController:alert animated:YES completion:nil];
        
    }
}


-(void)h_loadData{
    NSString *companyNickName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyNickName"];
    self.companyTitle.text = companyNickName;
    
    NSString *deptName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"deptName"];
    self.myTitle.text = deptName;
    
    self.noPerson.hidden = NO;
    self.noTitle.hidden = NO;
    NSString *empCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"empCode"];
    self.communicationViewModel.myEmpCode = empCode;
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.communicationViewModel.companyCode = companyCode;
    [self.communicationViewModel.refreshDataCommand execute:nil];
}

-(void)h_refreash{
    NSString *empCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"empCode"];
    self.communicationViewModel.myEmpCode = empCode;
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.communicationViewModel.companyCode = companyCode;
    [self.communicationViewModel.refreshDataCommand execute:nil];
}


-(void)h_bindViewModel{
    [[self.communicationViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            if (self.communicationViewModel.arr.count>0) {
                self.noPerson.hidden = YES;
                self.noTitle.hidden = YES;
            }else{
                self.noPerson.hidden = NO;
                self.noTitle.hidden = NO;
            }
        });
    }];
}


#pragma mark lazyload
-(CommunicationViewModel *)communicationViewModel{
    if (!_communicationViewModel) {
        _communicationViewModel = [[CommunicationViewModel alloc] init];
    }
    return _communicationViewModel;
}

- (ComSearchView *)searchBar{
    if (!_searchBar) {
        _searchBar = [[ComSearchView alloc]init];
        _searchBar.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchClick)];
        [_searchBar addGestureRecognizer:setTap];
    }
    return _searchBar;
}

-(void)searchClick{
    [self.communicationViewModel.searchSubject sendNext:nil];
    
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = ImageNamed(@"ic_organization");
    }
    return _icon;
}

-(UILabel *)companyTitle{
    if (!_companyTitle) {
        _companyTitle = [[UILabel alloc] init];
        _companyTitle.text = @"";
        _companyTitle.font = H14;
        _companyTitle.textColor = MAIN_PAN_2;
    }
    return _companyTitle;
}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.text = @"组织架构";
        _content.font = H12;
        _content.textColor = MAIN_PAN_3;
    }
    return _content;
}

-(UIImageView *)back1{
    if (!_back1) {
        _back1 = [[UIImageView alloc] init];
        _back1.image = ImageNamed(@"role_right_arrow");
    }
    return _back1;
}


-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line1;
}

-(UIView *)view1{
    if (!_view1) {
        _view1 = [[UIView alloc] init];
        _view1.userInteractionEnabled = YES;
        _view1.backgroundColor = white_color;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view1Click)];
        [_view1 addGestureRecognizer:setTap];
    }
    return _view1;
}

-(void)view1Click{
    [self.communicationViewModel.myCompanySubject sendNext:nil];
}

-(UIImageView *)myIcon{
    if (!_myIcon) {
        _myIcon = [[UIImageView alloc] init];
        _myIcon.image = ImageNamed(@"ic_tree");
    }
    return _myIcon;
}

-(UILabel *)myTitle{
    if (!_myTitle) {
        _myTitle = [[UILabel alloc] init];
        _myTitle.text = @"";
        _myTitle.font = H14;
        _myTitle.textColor = MAIN_PAN_2;
    }
    return _myTitle;
}

-(UILabel *)myContent{
    if (!_myContent) {
        _myContent = [[UILabel alloc] init];
        _myContent.text = @"我的部门";
        _myContent.font = H12;
        _myContent.textColor = MAIN_PAN_3;
    }
    return _myContent;
}

-(UIImageView *)back2{
    if (!_back2) {
        _back2 = [[UIImageView alloc] init];
        _back2.image = ImageNamed(@"role_right_arrow");
    }
    return _back2;
}

-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = MAIN_LINE_COLOR;
    }
    return _line2;
}

-(UIView *)view2{
    if (!_view2) {
        _view2 = [[UIView alloc] init];
        _view2.userInteractionEnabled = YES;
        _view2.backgroundColor = white_color;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view2Click)];
        [_view2 addGestureRecognizer:setTap];
    }
    return _view2;
}
-(void)view2Click{
    [self.communicationViewModel.myTeamSubject sendNext:nil];
}


-(UILabel *)collection{
    if (!_collection) {
        _collection = [[UILabel alloc] init];
        _collection.text = @"收藏的联系人";
        _collection.font = H14;
        _collection.textColor = MAIN_PAN_2;
    }
    return _collection;
}

-(UIImageView *)noPerson{
    if (!_noPerson) {
        _noPerson = [[UIImageView alloc] init];
        _noPerson.image = ImageNamed(@"ic_no_employee");
        _noPerson.hidden = YES;
    }
    return _noPerson;
}

-(UILabel *)noTitle{
    if (!_noTitle) {
        _noTitle = [[UILabel alloc] init];
        _noTitle.text = @"暂无收藏的联系人";
        _noTitle.font = H14;
        _noTitle.textColor = MAIN_PAN_2;
        _noTitle.hidden = YES;
    }
    return _noTitle;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BG_COLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[CommunicationCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CommunicationCellView class])]];
    }
    return _tableView;
    
}

#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.communicationViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommunicationCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CommunicationCellView class])] forIndexPath:indexPath];
    //   cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.communicationModel = self.communicationViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.communicationViewModel.cellclickSubject sendNext:row];
}


@end
