//
//  CommunicationViewModel.m
//  ATT考勤
//
//  Created by Helen on 17/4/17.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "CommunicationViewModel.h"

@implementation CommunicationViewModel

-(RACSubject *)tableViewSubject{
    if (!_tableViewSubject) {
        _tableViewSubject = [RACSubject subject];
    }
    return _tableViewSubject;
}

-(RACSubject *)cellclickSubject{
    if (!_cellclickSubject) {
        _cellclickSubject = [RACSubject subject];
    }
    return _cellclickSubject;
}

-(RACSubject *)myTeamSubject{
    if (!_myTeamSubject) {
        _myTeamSubject = [RACSubject subject] ;
    }
    return _myTeamSubject;
}


@end
