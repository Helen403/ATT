//
//  FeedbackView.m
//  ATT考勤
//
//  Created by Helen on 17/1/6.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "FeedbackView.h"
#import "FeedbackViewModel.h"
#import "FeedbackCellView.h"
#import "UserModel.h"


@interface FeedbackView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) FeedbackViewModel *feedbackViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation FeedbackView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.feedbackViewModel = (FeedbackViewModel *)viewModel;
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

-(void)h_viewWillAppear{
    
    NSString *companyCode =  [[NSUserDefaults standardUserDefaults] objectForKey:@"companyCode"];
    
    self.feedbackViewModel.companyCode = companyCode;
    UserModel *user =  getModel(@"user");
    self.feedbackViewModel.userCode = user.userCode;
    [self.feedbackViewModel.feedbackCommand execute:nil];
    
    
}

-(void)h_bindViewModel{
    [[self.feedbackViewModel.submitclickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
    }];
}



#pragma mark lazyload
-(FeedbackViewModel *)feedbackViewModel{
    if (!_feedbackViewModel) {
        _feedbackViewModel = [[FeedbackViewModel alloc] init];
    }
    return _feedbackViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[FeedbackCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([FeedbackCellView class])]];
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self h_w:80])];
        v.backgroundColor = GX_BGCOLOR;
        _tableView.tableFooterView = v;
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.feedbackViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeedbackCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([FeedbackCellView class])] forIndexPath:indexPath];
    
    cell.feedbackModel = self.feedbackViewModel.arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:195];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    //    [self.dealWithViewModel.cellclickSubject sendNext:row];
}


@end
