/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: UITextField的一些便捷操作
 https://github.com/yxiangBeauty/Project.git
 */


#import "UITextField+YXAdd.h"
#import <objc/runtime.h>
NSString * const WJTextFieldDidDeleteBackwardNotification = @"com.whojun.textfield.did.notification";
@implementation UITextField (YXAdd)

#pragma mark - 输入框范围限制
+ (void)load {
    //交换2个方法中的IMP
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(wj_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)wj_deleteBackward {
    [self wj_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <WJTextFieldDelegate> delegate  = (id<WJTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WJTextFieldDidDeleteBackwardNotification object:self];
}


- (void)spaceToLeft:(CGFloat)space
{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, space, 1)];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftView;
}

- (void)spaceToRight:(CGFloat)space
{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, space, 1)];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = rightView;
}

@end
