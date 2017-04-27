//
//  MyMsgView.m
//  ATT考勤
//
//  Created by Helen on 17/1/20.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MyMsgView.h"
#import "MyMsgViewModel.h"
#import "MyMsgCellView.h"
#import "UserModel.h"
#import "MyMsgModel.h"


@interface MyMsgView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) MyMsgViewModel *myMsgViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation MyMsgView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.myMsgViewModel = (MyMsgViewModel *)viewModel;
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
        
      
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除" message:@"确认要删除该消息" preferredStyle:UIAlertControllerStyleAlert];
        
        // 添加按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

            UserModel *user =  getModel(@"user");
            
            self.myMsgViewModel.userCode = user.userCode;
            NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
            self.myMsgViewModel.companyCode = companyCode;
            
            MyMsgModel *model = self.myMsgViewModel.arr[indexPath.row];
            self.myMsgViewModel.targetUserCode = model.msgUserCode;
            [self.myMsgViewModel.delMsgCommand execute:nil];
            
            [self.myMsgViewModel.arr removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }]];
        
        
        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
        
        [nav presentViewController:alert animated:YES completion:nil];
        
    }
}



-(void)h_bindViewModel{
    [[self.myMsgViewModel.successSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
    }];
}

-(void)h_loadData{
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    self.myMsgViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.myMsgViewModel.userCode = user.userCode;
    [self.myMsgViewModel.refreshDataCommand execute:nil];
}


#pragma mark lazyload
-(MyMsgViewModel *)myMsgViewModel{
    if (!_myMsgViewModel) {
        _myMsgViewModel = [[MyMsgViewModel alloc] init];
    }
    return _myMsgViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyMsgCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyMsgCellView class])]];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myMsgViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyMsgCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyMsgCellView class])] forIndexPath:indexPath];
    
    cell.myMsgModel = self.myMsgViewModel.arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:55];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.myMsgViewModel.cellclickSubject sendNext:row];
}

@end
