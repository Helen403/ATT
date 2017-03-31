/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: 用于UIView的便捷处理
 https://github.com/yxiangBeauty/Project.git
 */

#import <UIKit/UIKit.h>

@interface UIView (YXAdd)

@property (nonatomic) CGFloat left;        // < frame.origin.x
@property (nonatomic) CGFloat top;         // < frame.origin.y
@property (nonatomic) CGFloat right;       // < frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      // < frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       // < frame.size.width.
@property (nonatomic) CGFloat height;      // < frame.size.height.
@property (nonatomic) CGFloat centerX;     // < center.x
@property (nonatomic) CGFloat centerY;     // < center.y
@property (nonatomic) CGPoint origin;      // < frame.origin.
@property (nonatomic) CGSize  size;        // < frame.size.

/**
 清除所有加在本视图上的视图和图层
 */
- (void)clearAll;

- (UIImage *)convertViewToImage;
@end
