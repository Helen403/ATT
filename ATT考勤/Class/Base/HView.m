//
//  HView.m
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HView.h"
#import "AppDelegate.h"

@implementation HView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self h_setupViews];
        [self h_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<HViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        
        [self h_setupViews];
        [self h_bindViewModel];
    }
    return self;
}


- (void)h_setupViews {
}

- (void)h_bindViewModel {
}

- (void)h_addReturnKeyBoard {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.window endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}


@end
