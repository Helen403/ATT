//
//  AddressListController.m
//  ATT考勤
//
//  Created by Helen on 17/1/10.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AddressListController.h"
#import "AddressListView.h"
#import "AddressListViewModel.h"

#import "TeamController.h"
#import "EmployeeController.h"

#import "AddressListCellView.h"
#import "AddressListModel.h"

#import "ToTeamView.h"

@interface AddressListController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>

@property(nonatomic,strong) AddressListView *addressListView;

@property(nonatomic,strong) AddressListViewModel *addressListViewModel;

@property (nonatomic ,strong) UISearchBar *searchBar;

@property (nonatomic ,strong) UISearchDisplayController *searchDC;

@property (nonatomic ,strong) NSMutableArray *searchArr;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) ToTeamView *toTeamView;

@property(nonatomic,strong) UIView *content;

@end

@implementation AddressListController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark private
-(void)h_layoutNavigation{
    self.title = @"通讯录";
}

-(void)h_addSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    self.content.frame = CGRectMake(0, 0, SCREEN_WIDTH, 74);
    self.tableView.frame = CGRectMake(0,74,SCREEN_WIDTH, self.view.frame.size.height-74);
    
    //发送请求
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.addressListViewModel.companyCode = companyCode;
    [self.addressListViewModel.refreshDataCommand execute:nil];
}

-(void)h_bindViewModel{
    
    //跳转到部门通讯
    [[self.addressListViewModel.teamclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        TeamController *team = [[TeamController alloc] init];
        
        [self.navigationController pushViewController:team animated:NO];
        
    }];
    
    
    //点击每个人
    [[self.addressListViewModel.cellclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        [self performSelectorOnMainThread:@selector(mainThreadback:) withObject:x waitUntilDone:YES];
    }];
    
    //回调刷新tableView
    [[self.addressListViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        [self performSelectorOnMainThread:@selector(mainThread) withObject:nil waitUntilDone:YES];
    }];
    
}

-(void)mainThreadback:(NSNumber *)num{
    
    EmployeeController *employee = [[EmployeeController alloc] init];
    employee.addressListModel= self.addressListViewModel.arr[[num intValue]];
    [self.navigationController pushViewController:employee animated:NO];
}

-(void)mainThread{
    [self.tableView reloadData];
}

#pragma mark lazyload
-(AddressListView *)addressListView{
    if (!_addressListView) {
        _addressListView = [[AddressListView alloc] initWithViewModel:self.addressListViewModel];
    }
    return _addressListView;
}

-(AddressListViewModel *)addressListViewModel{
    if (!_addressListViewModel) {
        _addressListViewModel = [[AddressListViewModel alloc] init];
    }
    return _addressListViewModel;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText != nil && searchText.length > 0){
        
        self.searchArr = [NSMutableArray array];//这里可以说是清空tableview旧datasouce
        
        //遍历需要搜索的所有内容，其中self.dataArray为存放总数据的数组
        for (AddressListModel *model in self.addressListViewModel.arr) {
            
            NSString *tempStr = model.empName;
            
            //----------->把所有的搜索结果转成成拼音
            NSString *pinyin = [self transformToPinyin:tempStr];
            
            if ([pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length >0 ) {
                //把搜索结果存放self.resultArray数组
                [self.searchArr addObject:model];
            }
        }
        
        [_tableView reloadData];
    }else{
        self.searchArr = [NSMutableArray arrayWithArray:self.addressListViewModel.arr];
        [_tableView reloadData];
    }
}

- (NSString *)transformToPinyin:(NSString *)aString{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int i = 0; i < pinyinArray.count; i++){
        for(int i = 0; i < pinyinArray.count;i++){
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
            
        }
        [allString appendString:@","];
        count ++;
    }
    
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    
    for (NSString *s in pinyinArray){
        if (s.length > 0){
            
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    
    return allString;
}

-(UIView *)content{
    if (!_content) {
        _content = [[UIView alloc] init];
        _content.frame = CGRectMake(0, 0, SCREEN_WIDTH, 74);
        [_content addSubview:self.searchBar];
        [_content addSubview:self.toTeamView];
        [self.view addSubview:_content];
    }
    return _content;
}

-(ToTeamView *)toTeamView{
    if (!_toTeamView) {
        _toTeamView = [[ToTeamView alloc] init];
        _toTeamView.backgroundColor = white_color;
        _toTeamView.frame = CGRectMake(0, 44, SCREEN_WIDTH,30);
        _toTeamView.userInteractionEnabled = YES;
        UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toTeam)];
        [_toTeamView addGestureRecognizer:setTap];
    }
    return _toTeamView;
}


-(void)toTeam{
    [self.addressListViewModel.teamclickSubject sendNext:nil];
}

- (UISearchDisplayController *)searchDC{
    if (!_searchDC) {
        _searchDC = [[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
        _searchDC.delegate = self;
        _searchDC.searchResultsDelegate = self;
        _searchDC.searchResultsDataSource = self;
    }
    return _searchDC;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"姓名/手机号";
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH,44);
    }
    return _searchBar;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[AddressListCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([AddressListCellView class])]];
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.15)];
        
    }
    return _tableView;
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.searchDC.searchResultsTableView) {
        return self.searchArr.count;//搜索结果
    }else
        return self.addressListViewModel.arr.count;//原始数据
    
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.tableView) {
        AddressListCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AddressListCellView class])] forIndexPath:indexPath];
        
        cell.addressListModel = self.addressListViewModel.arr[indexPath.row];
        return cell;
    }else
    {
        static NSString *identify = @"cellIdentify";
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        //把符合搜索条件的内容展示出来
        AddressListModel *model = self.searchArr[indexPath.row];
        cell.textLabel.text = model.empName;
        return cell;
        
    }
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.addressListViewModel.cellclickSubject sendNext:row];
}

@end
