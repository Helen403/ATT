//
//  HCollectionViewCell.m
//  ATT考勤
//
//  Created by Helen on 16/12/15.
//  Copyright © 2016年 Helen. All rights reserved.
//

#import "HCollectionViewCell.h"

@implementation HCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self h_setupViews];
    }
    return self;
}

- (void)h_setupViews {}


-(NSInteger)h_w:(NSInteger)width{
    return autoScaleW(width);
}


@end
