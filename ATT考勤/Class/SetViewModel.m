//
//  SetViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/1/4.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "SetViewModel.h"
#import "SetModel.h"


@implementation SetViewModel

-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
        //读取plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Set" ofType:@"plist"];
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        
        _arr= [SetModel mj_objectArrayWithKeyValuesArray:data];

    }
    return _arr;
}

-(RACSubject *)cellclickSubject{
    
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}


-(RACSubject *)exitclickSubject{
    if (!_exitclickSubject) {
        _exitclickSubject = [RACSubject subject];
    }
    return _exitclickSubject;

}
@end
