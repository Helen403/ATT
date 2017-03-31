/**
 Copyright (c) 2016-present, yxiang.
 All rights reserved.
 Description: 用于字典转化为模型
 Notice: 这里没有过多的处理性能相关的问题，基本能够满足要求
 https://github.com/yxiangBeauty/Project.git
 */

#import "NSObject+YXAdd.h"
#import <objc/runtime.h>

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
//  自定义监听对象
@interface YXObjectAddKVOBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(__weak id obj, NSDictionary *change);

- (id)initWithBlock:(void (^)(__weak id obj, NSDictionary *change))block;

@end

@implementation YXObjectAddKVOBlockTarget

- (id)initWithBlock:(void (^)(__weak id obj, NSDictionary *change))block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (!self.block) return;
    self.block(object, change);
}

@end
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
@implementation NSObject (YXAdd)

+ (instancetype)dictionaryToModel:(NSDictionary *)dict
{
    NSObject *object = [[self alloc] init];
    NSArray *properties = [self getAllProperties];
    [properties enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *proName = obj;
        id value = dict[proName];
        if (!value || [value isKindOfClass:[NSNull class]]) {
            // 如果为null对象，则转化为字符串@""
            value = @"";
        }else if ([value isKindOfClass:[NSNumber class]]) {
            // 如果为NSNumber对象则转化为NSString对象
            value = [NSString stringWithFormat:@"%@",value];
        }
        [object setValue:value forKeyPath:proName];
    }];
    return object;
}

/* 获取对象的所有属性 */
+ (NSArray *)getAllProperties
{
    u_int count;
    // 传递count的地址过去 &count
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    // arrayWithCapacity的效率稍微高那么一丢丢
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        // 此刻得到的propertyName为c语言的字符串
        const char* propertyName =property_getName(properties[i]);
        // 此步骤把c语言的字符串转换为OC的NSString
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    // class_copyPropertyList底层为C语言，所以我们一定要记得释放properties
    free(properties);
    return propertiesArray;
}

#pragma mark - KVO

- (void)addObserverForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options respondActionBlock:(KVOObserverBlock)aBlock
{
    if (!keyPath || !aBlock) return;
    // 初始化监听对象
    YXObjectAddKVOBlockTarget *target = [[YXObjectAddKVOBlockTarget alloc] initWithBlock:aBlock];
    // 获取所有监听对象
    NSMutableDictionary *dic = [self allObjectObserverBlocks];
    // 将观察路径和监听对象存入字典中
    // 如果还没有该路径的监听者，则新建一个数组存储
    NSMutableArray *arr = dic[keyPath];
    if (!arr) {
        arr = [NSMutableArray new];
        dic[keyPath] = arr;
    }
    // 如果有，则直接存储
    [arr addObject:target];
    // 添加观察者
    [self addObserver:target forKeyPath:keyPath options:options context:NULL];
}

- (void)removeObserverBlocksForKeyPath:(NSString *)keyPath
{
    if (!keyPath) return;
    NSMutableDictionary *dic = [self allObjectObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeObserver:obj forKeyPath:keyPath];
    }];
    [dic removeObjectForKey:keyPath];
}

- (void)removeObserverBlocks
{
    NSMutableDictionary *dic = [self allObjectObserverBlocks];
    [dic enumerateKeysAndObjectsUsingBlock: ^(NSString *key, NSArray *arr, BOOL *stop) {
        [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
            [self removeObserver:obj forKeyPath:key];
        }];
    }];
    [dic removeAllObjects];
}

/// TODO: 缓存关于观察者的信息
static const char *kAllObjectObserverBlocks = "allObjectObserverBlocksKey";
- (NSMutableDictionary *)allObjectObserverBlocks
{
    NSMutableDictionary *targets = objc_getAssociatedObject(self, kAllObjectObserverBlocks);
    if (!targets) {
        targets = [NSMutableDictionary new];
        objc_setAssociatedObject(self, kAllObjectObserverBlocks, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
