//
//  LYWCollectionViewCell.m
//  ATT考勤
//
//  Created by Helen on 17/3/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "LYWCollectionViewCell.h"
#import "TriangleView.h"

@implementation LYWCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _dateLable = [[UILabel alloc] initWithFrame:self.bounds];
        [_dateLable setTextAlignment:NSTextAlignmentCenter];
        [_dateLable setFont:[UIFont systemFontOfSize:17]];
        _dateLable.textColor = [UIColor blackColor];
        TriangleView *triangleView =  [[TriangleView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height/2)];
        
        [self addSubview:_dateLable];
        [self addSubview:triangleView];
    }
    return self;
}

@end
