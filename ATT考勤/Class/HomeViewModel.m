//
//  HomeViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/21.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

-(RACSubject *)headclickSubject{
    if (!_headclickSubject) {
        _headclickSubject = [RACSubject subject];
    }
    return _headclickSubject;

}

-(RACSubject *)setClickSubject{
    if (!_setClickSubject) {
        _setClickSubject = [RACSubject subject];
    }
    return _setClickSubject;

}

@end
