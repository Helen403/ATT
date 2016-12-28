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

@interface MyExamineView()

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
    WS(weakSelf);
    [super updateConstraints];

}

#pragma mark private
-(void)h_setupViews{

    self.backgroundColor = red_color;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)h_bindViewModel{

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
        _tableView.backgroundColor = GX_BGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyExamineTableCellView class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyExamineTableCellView class])]];
        
        
    }
    return _tableView;

}

#pragma mark - delegate
#pragma mark tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyExamineTableCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyExamineTableCellView class])] forIndexPath:indexPath];
    
//    cell.loginViewCellViewModel = self.loginViewModel.alArray[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self.loginViewModel.cellClickSubject sendNext:nil];
}


@end
