//
//  HViewModel.m
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HViewModel.h"

@implementation HViewModel
@synthesize request  = _request;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    HViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel h_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (CMRequest *)request {
    
    if (!_request) {
        
        _request = [CMRequest request];
    }
    return _request;
}

- (void)h_initialize {}




@end
