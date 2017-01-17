//
//  OvertimeViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/16.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "OvertimeViewModel.h"

@implementation OvertimeViewModel

-(RACSubject *)submitclickSubject{
    if (!_submitclickSubject) {
        _submitclickSubject = [RACSubject subject];
    }
    return _submitclickSubject;
}

@end
