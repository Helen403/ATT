//
//  ForgetViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/23.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "ForgetViewModel.h"

@implementation ForgetViewModel


-(RACSubject *)forgetPwdclickSubject{

    if (!_forgetPwdclickSubject) {
        _forgetPwdclickSubject = [RACSubject subject];
    }
    return _forgetPwdclickSubject;
}

@end
