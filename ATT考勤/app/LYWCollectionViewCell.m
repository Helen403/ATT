//
//  LYWCollectionViewCell.m
//  ATT考勤
//
//  Created by Helen on 17/3/9.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "LYWCollectionViewCell.h"


@implementation LYWCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _dateLable = [[UILabel alloc] initWithFrame:self.bounds];
        [_dateLable setTextAlignment:NSTextAlignmentCenter];
        [_dateLable setFont:[UIFont systemFontOfSize:17]];
        _dateLable.textColor = [UIColor blackColor];
        _triangleView =  [[TriangleView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2+5, frame.size.height/2+5)];
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(1, 2, frame.size.width/2, frame.size.width/4)];
        _title.text = @"";
        _title.font = H8;
        _title.textColor = MAIN_PAN_2;

   
        
        [self addSubview:_dateLable];
        [self addSubview:_triangleView];
        [self addSubview:_title];
    }
    return self;
}

@end
