//
//  BuildRoleViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/26.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "BuildRoleViewModel.h"
#import "BuildRoleModel.h"

@implementation BuildRoleViewModel

-(RACSubject *)companyCodeclickSubject{
    if (!_companyCodeclickSubject) {
        _companyCodeclickSubject = [RACSubject subject];
    }
    return _companyCodeclickSubject;

}

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BuildRole" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr = [BuildRoleModel mj_objectArrayWithKeyValuesArray:data];
    }
    return _arr;
}



@end
