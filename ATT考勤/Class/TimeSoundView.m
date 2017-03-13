//
//  TimeSoundView.m
//  ATT考勤
//
//  Created by Helen on 17/3/13.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TimeSoundView.h"

@interface TimeSoundView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@end


@implementation TimeSoundView

//-(UITableView *)tableView{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] init];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.backgroundColor = GX_BGCOLOR;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView registerClass:[<#DealWithCellView#> class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([<#DealWithCellView#> class])]];
//        
//    }
//    return _tableView;
//    
//}
//
//
//#pragma mark - delegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return 4;
//}
//
//#pragma mark tableViewDataSource
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    <#DealWithCellView#> *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([<#DealWithCellView#> class])] forIndexPath:indexPath];
//    
//    //    cell.dealWithModel = self.dealWithViewModel.arr[indexPath.row];
//    
//    return cell;
//}
//
//#pragma mark UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return [self h_w:40];
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSNumber *row =[NSNumber numberWithInteger:indexPath.row];
//    //    [self.dealWithViewModel.cellclickSubject sendNext:row];
//}


@end
