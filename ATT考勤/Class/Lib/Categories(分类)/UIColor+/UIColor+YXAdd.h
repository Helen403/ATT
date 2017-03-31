/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: 用于基于颜色相关的操作
 https://github.com/yxiangBeauty/Project.git
 */

#import <UIKit/UIKit.h>

@interface UIColor (YXAdd)

/**
 将十六进制数直接转化为UIColor对象
 */
UIColor * ColorWithHex(uint32_t hexColor);

/**
 根据十六进制和颜色的透明度初始化UIColor对象
 */
UIColor * ColorWithHexAndOpacity(uint32_t hexColor,CGFloat opacity);

/**
 根据比例将两个颜色混合，返回UIColor对象
 @param ratio 混合比例，color1*ratio+color2*ratio
 */
UIColor * MixColor(UIColor *color1, UIColor *color2, CGFloat ratio);

/**
 根据UIColor对象初始化一个UIImage对象，UIImage对象的大小由rect控制
 */
UIImage * CreateImageWithColor(UIColor * color, CGRect rect);

@end
