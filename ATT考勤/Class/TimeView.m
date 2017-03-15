//
//  TimeView.m
//  ATT考勤
//
//  Created by Helen on 17/1/5.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TimeView.h"
#import "TimeViewModel.h"
#import "TimeCellView.h"
#import "UserModel.h"
#import "TimeSoundView.h"
#import "TimeSoundViewModel.h"



@interface TimeView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) TimeViewModel *timeViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) TimeSoundView *timeSoundView;

@property(nonatomic,strong) TimeSoundViewModel *timeSoundViewModel;

@end

@implementation TimeView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.timeViewModel = (TimeViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [super updateConstraints];
}


-(void)h_setupViews{
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)h_loadData{
    WS(weakSelf);
    self.timeSoundView.clickBlock = ^(NSInteger count){
        [weakSelf.tableView reloadData];
    };

}

-(void)h_bindViewModel{
    [[self.timeViewModel.tableViewSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *x) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)h_viewWillAppear{
    UserModel *user =  getModel(@"user");
    self.timeViewModel.userCode = user.userCode;
    [self.timeViewModel.refreshDataCommand execute:nil];
}

-(void)h_viewWillDisappear{
    UserModel *user =  getModel(@"user");
    self.timeViewModel.userCode = user.userCode;
    [self.timeViewModel.modifyCommand execute:nil];
}

#pragma mark lazyload
-(TimeViewModel *)timeViewModel{
    if (!_timeViewModel) {
        _timeViewModel = [[TimeViewModel alloc] init];
    }
    return _timeViewModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TimeCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TimeCellView class])]];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.timeViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TimeCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TimeCellView class])] forIndexPath:indexPath];
    if(!(indexPath.row==1)){
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.index = indexPath.row;
    cell.timeModel = self.timeViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:50];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self click1];
}

-(void)click1{
    self.timeSoundView.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.8, self.timeSoundViewModel.arr.count*[self h_w:40]);
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
    [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
    [[HWPopTool sharedInstance] showWithPresentView:self.timeSoundView animated:NO];

}


-(TimeSoundView *)timeSoundView{
    if (!_timeSoundView) {
        _timeSoundView = [[TimeSoundView alloc] initWithViewModel:self.timeSoundViewModel];
    }
    return _timeSoundView;
}

-(TimeSoundViewModel *)timeSoundViewModel{
    if (!_timeSoundViewModel) {
        _timeSoundViewModel = [[TimeSoundViewModel alloc] init];
    }
    return _timeSoundViewModel;
}


@end
