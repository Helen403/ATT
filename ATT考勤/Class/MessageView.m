//
//  MessageView.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "MessageView.h"
#import "MessageViewModel.h"
#import "MessageCellView.h"
#import "UserModel.h"

@interface MessageView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) MessageViewModel *messageViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end


@implementation MessageView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.messageViewModel = (MessageViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(1);
        make.bottom.equalTo(0);
        
    }];
    
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    self.backgroundColor = GX_BGCOLOR;
    
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)h_bindViewModel{
    [[self.messageViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


-(void)h_viewWillAppear{
    UserModel *user =  getModel(@"user");
    self.messageViewModel.userCode = user.userCode;
    [self.messageViewModel.refreshDataCommand execute:nil];
}

-(void)h_viewWillDisappear{
    UserModel *user =  getModel(@"user");
    self.messageViewModel.userCode = user.userCode;
    [self.messageViewModel.modifyCommand execute:nil];
}


#pragma mark lazyload
-(MessageViewModel *)messageViewModel{
    if (!_messageViewModel) {
        _messageViewModel = [[MessageViewModel alloc] init];
    }
    return _messageViewModel;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MessageCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MessageCellView class])]];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.messageViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MessageCellView class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row;
    cell.messageModel = self.messageViewModel.arr[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
}

@end
