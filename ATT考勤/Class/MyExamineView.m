//
//  MyExamineView.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "MyExamineView.h"
#import "MyExamineViewModel.h"
#import "MyExamineTableCellView.h"
#import "UserModel.h"

@interface MyExamineView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) MyExamineViewModel *myExamineViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation MyExamineView
#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{

    self.myExamineViewModel = (MyExamineViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}


-(void)updateConstraints{

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
        make.top.equalTo(3);
    }];
    
    [super updateConstraints];

}

#pragma mark private
-(void)h_setupViews{

    self.backgroundColor = white_color;
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.myExamineViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.myExamineViewModel.userCode = user.userCode;
    [self.myExamineViewModel.LrefreshDataCommand execute:nil];
    [self.myExamineViewModel.ArefreshDataCommand execute:nil];
    [self.myExamineViewModel.RrefreshDataCommand execute:nil];
    [self.myExamineViewModel.CrefreshDataCommand execute:nil];
}

-(void)h_viewWillAppear{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.myExamineViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.myExamineViewModel.userCode = user.userCode;
    [self.myExamineViewModel.LrefreshDataCommand execute:nil];
    [self.myExamineViewModel.ArefreshDataCommand execute:nil];
    [self.myExamineViewModel.RrefreshDataCommand execute:nil];
    [self.myExamineViewModel.CrefreshDataCommand execute:nil];
}

-(void)h_bindViewModel{

    [[self.myExamineViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


#pragma mark lazyload
-(MyExamineViewModel *)myExamineViewModel{
    if (!_myExamineViewModel) {
        _myExamineViewModel = [[MyExamineViewModel alloc] init];
    }
    return _myExamineViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = white_color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyExamineTableCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyExamineTableCellView class])]];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;

}

#pragma mark - delegate
#pragma mark tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myExamineViewModel.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyExamineTableCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyExamineTableCellView class])] forIndexPath:indexPath];
    
    cell.myExamineModel = self.myExamineViewModel.arr[indexPath.row];
    
    if ([cell.myExamineModel.hint isEqualToString:@"0"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
  
        NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
        [self.myExamineViewModel.cellclickSubject sendNext:row];
    
    
}





@end
