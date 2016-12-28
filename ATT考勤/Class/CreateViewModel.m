//
//  CreateViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "CreateViewModel.h"

@implementation CreateViewModel

-(RACSubject *)buildRoleclickSubject{
    if (!_buildRoleclickSubject) {
        _buildRoleclickSubject = [RACSubject subject];
    }
    return _buildRoleclickSubject;
}

@end
