//
//  ApplyViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ApplyViewModel.h"

@implementation ApplyViewModel

-(RACSubject *)myApplyclickSubject{
    if (!_myApplyclickSubject) {
        _myApplyclickSubject = [RACSubject subject];
    }
    return _myApplyclickSubject;
}

-(RACSubject *)myExamineclickSubject{
    if (!_myExamineclickSubject) {
        _myExamineclickSubject = [RACSubject subject];
    }
    return _myExamineclickSubject;

}

@end
