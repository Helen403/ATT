//
//  NewpartViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "NewpartViewModel.h"

@implementation NewpartViewModel


-(RACSubject *)createclickSubject{
    if (!_createclickSubject) {
        _createclickSubject = [RACSubject subject];
    }
    return _createclickSubject;
}

@end
