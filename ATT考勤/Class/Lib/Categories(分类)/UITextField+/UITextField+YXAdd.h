/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: UITextField的一些便捷操作
 https://github.com/yxiangBeauty/Project.git
 */

#import <UIKit/UIKit.h>


@protocol WJTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end

@interface UITextField (YXAdd)

@property (weak, nonatomic) id<WJTextFieldDelegate> delegate;

#pragma mark - 输入框范围限制

/**
 从左边的第几个位置开始输入
 */
- (void)spaceToLeft:(CGFloat)space;

/**
 右边的结束位置
 */
- (void)spaceToRight:(CGFloat)space;

@end

/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * const WJTextFieldDidDeleteBackwardNotification;
