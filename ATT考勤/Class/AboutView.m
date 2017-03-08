//
//  AbountView.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "AboutView.h"
#import "AboutViewModel.h"
#import "AboutCellView.h"

@interface AboutView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) AboutViewModel *aboutViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIView *view;

@property(nonatomic,strong) UIImageView *twoDimension;


@end

@implementation AboutView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.aboutViewModel = (AboutViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(AboutViewModel *)aboutViewModel{
    if (!_aboutViewModel) {
        _aboutViewModel = [[AboutViewModel alloc] init];
    }
    return _aboutViewModel;
}

-(UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] init];
        _view.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self h_w:270]);
        [_view addSubview:self.twoDimension];
    }
    return _view;
}

-(UIImageView *)twoDimension{
    if (!_twoDimension) {
        _twoDimension = [[UIImageView alloc] init];
        _twoDimension.image = ImageNamed(@"2e2bb1e0");
        _twoDimension.frame = CGRectMake((SCREEN_WIDTH-[self h_w:250])*0.5, [self h_w:10], [self h_w:250], [self h_w:250]);
    }
    return _twoDimension;
    
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[AboutCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([AboutCellView class])]];
        _tableView.scrollEnabled = NO;
        
        _tableView.tableHeaderView = self.view;
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.aboutViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AboutCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AboutCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.aboutModel = self.aboutViewModel.arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
}

@end
