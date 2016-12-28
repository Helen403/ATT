//
//  HTableViewHeaderFooterView.m
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HTableViewHeaderFooterView.h"

@implementation HTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self h_setupViews];
    }
    return self;
}

- (void)h_setupViews{}



@end
