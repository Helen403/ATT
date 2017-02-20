//
//  SetView.m
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "SetView.h"
#import "SetViewModel.h"
#import "SetCellView.h"

@interface SetView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) SetViewModel *setViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIButton *button;

@end

@implementation SetView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.setViewModel = (SetViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];

    [super updateConstraints];
}


-(void)h_setupViews{
    
    self.backgroundColor = GX_BGCOLOR;
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(SetViewModel *)setViewModel{
    if (!_setViewModel) {
        _setViewModel = [[SetViewModel alloc] init];
    }
    return _setViewModel;
}


-(UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"退出登陆" forState:UIControlStateNormal];
        _button.titleLabel.font = H22;
        [_button addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
        
        [_button.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        [_button.layer setCornerRadius:10];
        
        [_button.layer setBorderWidth:2];//设置边界的宽度
        
        [_button setBackgroundColor:MAIN_ORANGER];
        //设置按钮的边界颜色

        [_button.layer setBorderColor:MAIN_ORANGER.CGColor];
        
    }
    return _button;
    
}
//退出登陆
-(void)exit:(UIButton *)button{
    [self.setViewModel.exitclickSubject sendNext:nil];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SetCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([SetCellView class])]];
        //设置tableview 不能滚动
        //        _tableView.scrollEnabled =NO;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self h_w:55])];
        _tableView.tableFooterView = view;
        [view addSubview:self.button];
        self.button.frame = CGRectMake([self h_w:10], [self h_w:15], SCREEN_WIDTH-2*[self h_w:10], [self h_w:35]);
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.setViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SetCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([SetCellView class])] forIndexPath:indexPath];
    
    cell.setModel = self.setViewModel.arr[indexPath.row];
    if (indexPath.row == 0) {
        [cell setImgHidden:NO];
    }else{
       [cell setImgHidden:YES];
    }

    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.setViewModel.cellclickSubject sendNext:row];
}


@end
