//
//  CopyView.m
//  ATT考勤
//
//  Created by Helen on 17/1/18.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CopyView.h"
#import "CopyViewModel.h"
#import "CopyCellView.h"

@interface CopyView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) CopyViewModel *toViewModel;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation CopyView

#pragma mark system
-(instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel{
    self.toViewModel = (CopyViewModel *)viewModel;
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
    
    self.backgroundColor = GX_BGCOLOR;
    
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}



#pragma mark lazyload
-(CopyViewModel *)toViewModel{
    if (!_toViewModel) {
        _toViewModel = [[CopyViewModel alloc] init];
    }
    return _toViewModel;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[CopyCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CopyCellView class])]];
    }
    return _tableView;
}



#pragma mark - delegate
#pragma mark tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.toViewModel.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CopyCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CopyCellView class])] forIndexPath:indexPath];
    
    cell.toMeModel = self.toViewModel.arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self h_w:40];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
    [self.toViewModel.cellclickSubject sendNext:row];
}

@end
