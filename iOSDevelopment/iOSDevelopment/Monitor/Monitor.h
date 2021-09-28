//
//  Monitor.h
//  iOSDevelopment
//
//  Created by 大明 on 2021/9/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Monitor : NSObject

/**
 监控某个线程CPU使用过高问题
 */
+ (void)updateCPU;

/**
 监控所有线程CPU使用问题
 */
+ (float)currentCPUUsage;

/**
 实际物理内存的使用情况
 */
+ (NSUInteger)memoryUsage;

@end

NS_ASSUME_NONNULL_END
