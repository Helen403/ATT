//
//  TeamAttendanceView.m
//  ATT考勤
//
//  Created by Helen on 17/1/11.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TeamAttendanceView.h"
#import "TeamAttendanceViewModel.h"
#import "TeamAttendanceCellView.h"

@interface TeamAttendanceView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) TeamAttendanceViewModel *teamAtttendanceViewModel;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UILabel *title;

@end


@implementation TeamAttendanceView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    
    self.teamAtttendanceViewModel = (TeamAttendanceViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)updateConstraints{
    
    WS(weakSelf);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([self h_w:10]);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset([self h_w:10]);
        make.right.equalTo(0);
        make.left.equalTo(0);
        make.bottom.equalTo(0);
    }];
    [super updateConstraints];
}

#pragma mark private
-(void)h_setupViews{
    
    self.backgroundColor = MAIN_GRAY;
    
    [self addSubview:self.title];
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark lazyload
-(TeamAttendanceViewModel *)teamAtttendanceViewModel{
    if (!_teamAtttendanceViewModel) {
        _teamAtttendanceViewModel = [[TeamAttendanceViewModel alloc] init];
    }
    return _teamAtttendanceViewModel;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"2016年12月25日";
        _title.font = H14;
        _title.textColor = white_color;
    }
    return _title;

}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TeamAttendanceCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamAttendanceCellView class])]];
        
    }
    return _tableView;
    
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.teamAtttendanceViewModel.arr.count;
}

#pragma mark tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeamAttendanceCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TeamAttendanceCellView class])] forIndexPath:indexPath];
    
    cell.teamAttendanceModel = self.teamAtttendanceViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.teamAtttendanceViewModel.cellclickSubject sendNext:row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self h_w:40];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = BG_COLOR;
    UILabel *text = [[UILabel alloc] init];
    text.font = H14;
    text.textColor = MAIN_PAN_2;
    if (section == 0) {
        text.text = @"上午上班09:00";
    }else if(section == 1){
        text.text = @"下午下班18:00";
    }
    text.frame = CGRectMake([self h_w:10], 0, SCREEN_WIDTH, [self h_w:40]);
    
    [headView addSubview:text];
    return headView;
}

@end
