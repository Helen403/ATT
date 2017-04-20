//
//  ApplyManViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/3/2.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "ApplyManViewModel.h"
#import "TeamListModel.h"

@implementation ApplyManViewModel


-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        TeamListModel *teamListModel = [[TeamListModel alloc] init];
        teamListModel.empColor = @"#177EF1";
        teamListModel.empName = @"+";
        [_arr addObject:teamListModel];
    }
    return _arr;
}

-(RACSubject *)cellclickSubject{
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}

@end
