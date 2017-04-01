//
//  TriangleView.m
//  ATT考勤
//
//  Created by Helen on 17/4/1.
//  Copyright © 2017年 Helen. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
    
}

- (void)drawRect:(CGRect)rect {
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 0, 0);
    
    CGContextAddLineToPoint(context, rect.size.width, 0);
    
    CGContextAddLineToPoint(context, 0, rect.size.height);
    

    
    CGContextClosePath(context);
    
    [[UIColor whiteColor] setStroke];
    
    [[UIColor redColor] setFill];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

@end
