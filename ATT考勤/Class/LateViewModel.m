//
//  ApplicationViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/27.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "LateViewModel.h"
#import "LateModel.h"

@implementation LateViewModel

-(RACSubject *)submitclickSubject{
    if (!_submitclickSubject) {
        _submitclickSubject = [RACSubject subject];
    }
    return _submitclickSubject;
}



@end
