/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: 用于基于颜色相关的操作
 https://github.com/yxiangBeauty/Project.git
 */

#import "UIColor+YXAdd.h"

@implementation UIColor (YXAdd)

UIColor * ColorWithHex(uint32_t hexColor)
{
    return ColorWithHexAndOpacity(hexColor,1);
}

UIColor * ColorWithHexAndOpacity(uint32_t hexColor, CGFloat opacity)
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

UIImage * CreateImageWithColor(UIColor * color, CGRect rect)
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

UIColor * MixColor(UIColor *color1, UIColor *color2, CGFloat ratio)
{
    if(ratio > 1) ratio = 1;
    const CGFloat * components1 = CGColorGetComponents(color1.CGColor);
    const CGFloat * components2 = CGColorGetComponents(color2.CGColor);
    CGFloat r = components1[0]*ratio + components2[0]*(1-ratio);
    CGFloat g = components1[1]*ratio + components2[1]*(1-ratio);
    CGFloat b = components1[2]*ratio + components2[2]*(1-ratio);
    CGFloat alpha = components1[3]*ratio + components2[3]*(1-ratio);
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

@end
