//
//  NSObject+YLT_Extension.h
//  YLT_BaseLib
//
//  Created by YLT_Alex on 2017/10/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define YLT_LockBlock() dispatch_semaphore_wait(self.ylt_semaphoreBlock, DISPATCH_TIME_FOREVER);
#define YLT_UnlockBlock() dispatch_semaphore_signal(self.ylt_semaphoreBlock);

#define YLT_Lock() dispatch_semaphore_wait(self.ylt_semaphore, DISPATCH_TIME_FOREVER);
#define YLT_Unlock() dispatch_semaphore_signal(self.ylt_semaphore);

void ylt_swizzleClassMethod(Class cls, SEL originSelector, SEL newSelector);
void ylt_swizzleInstanceMethod(Class cls, SEL originSelector, SEL newSelector);

@interface NSObject (YLT_Extension)

/**
 用来保证线程安全
 */
@property (nonatomic, strong) dispatch_semaphore_t ylt_semaphore;

/**
 用来保证线程安全
 */
@property (nonatomic, strong) dispatch_semaphore_t ylt_semaphoreBlock;

/** 第一个元素，主要用在数组中 */
@property (nonatomic, assign) BOOL ylt_isFirst;
/** 最后一个元素，主要用在数组 */
@property (nonatomic, assign) BOOL ylt_isLast;
/** 是否选中，主要用在数组 */
@property (nonatomic, assign) BOOL ylt_isSelected;

/**
 获取当前的控制器

 @return 当前控制器
 */
- (UIViewController *)ylt_currentVC;

/**
 方法交换 类方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)ylt_swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector;

/**
 方法交换 实例方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)ylt_swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;

/**
 *  存储对象
 *
 *  @param key key
 */
- (void)ylt_storeValueWithKey:(NSString *)key;

/**
 *  获取对象
 *
 *  @param key key
 *
 *  @return 对象
 */
+ (id)ylt_valueByKey:(NSString *)key;

/**
 *  移除对象
 *
 *  @param key key
 */
+ (void)ylt_removeValueForKey:(NSString *)key;

@end
