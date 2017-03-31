/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: 用于字典转化为模型
 Notice: 这里没有过多的处理性能相关的问题，基本能够满足要求
 https://github.com/yxiangBeauty/Project.git
 */

#import <Foundation/Foundation.h>

@interface NSObject (YXAdd)

/**
 字典转模型，数字对象和空对象自动转化为NSString
 */
+ (instancetype)dictionaryToModel:(NSDictionary *)dict;

#pragma mark - KVO的Block封装

/**********************************************************************************************
 **********************************************************************************************
            实现原理和KVO的类似，通过派生中间类，使用该类注册观察者，在实现方法中转化为Block回调。
 **********************************************************************************************
 **********************************************************************************************/

/**
 KVO获得通知时的回调

 @param obj     观察者
 @param change  改变参数
 */
typedef void(^KVOObserverBlock)(__weak id obj, NSDictionary *change);

/**
 添加观察者

 @param keyPath 观察路径
 @param options 被观察者的改变量
 @param aBlock  回调
 */
- (void)addObserverForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options respondActionBlock:(KVOObserverBlock)aBlock;

/**
 移除指定路径下，通过Block回调添加的观察者
 */
- (void)removeObserverBlocksForKeyPath:(NSString *)keyPath;

/**
 移除所有通过Block回调添加的观察者
 */
- (void)removeObserverBlocks;

@end
