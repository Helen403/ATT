/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: UIButton的一些便捷操作
 https://github.com/yxiangBeauty/Project.git
 */

#import <UIKit/UIKit.h>

@interface UIButton (YXAdd)

#pragma mark - Block回调

/**
 按钮的Block回调
 */
typedef void(^ButtonActionBlock)(UIButton *sender);

/**
 添加事件响应，通过Block回调
 */
- (void)addTouchUpInsideActionForBlock:(ButtonActionBlock)aBlock;

#pragma mark - 自定义title和image位置

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, YXButtonEdgeInsetsStyle) {
    ImageTop,     // < image在上，label在下
    ImageLeft,    // < image在左，label在右
    ImageBottom,  // < image在下，label在上
    ImageRight    // < image在右，label在左
};

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *  感谢来自http://www.open-open.com/lib/view/open1482115852677.html的分享
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)edgeInsetsStyle:(YXButtonEdgeInsetsStyle)style imgTitleSpace:(CGFloat)space;

@end
