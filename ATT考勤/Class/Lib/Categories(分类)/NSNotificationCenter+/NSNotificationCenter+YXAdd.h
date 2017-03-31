/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: NSNotificationCenter的一些便捷操作
 https://github.com/yxiangBeauty/Project.git
 */

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (YXAdd)

#pragma mark - Block封装
/**
 通知中心回调Block

 @param anObject 传入的anObject对象
 */
typedef void(^NSNBlock)(id anObject);

/**
 添加通知中心观察者

 @param aName       通知标识符
 @param anObject    传入的对象
 @param aBlock      回调
 */
//- (void)addObserverWithName:(NSNotificationName)aName forObject:(id)anObject respondBlock:(NSNBlock)aBlock;

/**
 移除标识符的所有观察者
 */
//- (void)removeBlockObseverForName:(NSNotificationName)aName;

/**
 移除所有观察者
 */
- (void)removeBlockObsever;

@end
