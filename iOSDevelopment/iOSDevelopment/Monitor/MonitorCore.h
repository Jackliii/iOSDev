//
//  MonitorCore.h
//  iOSDevelopment
//
//  Created by 大明 on 2021/9/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MonitorCore : NSObject

@property (nonatomic, assign, readonly) NSInteger fps;

@property (nonatomic, assign, readonly) NSInteger cpu;

@property (nonatomic, assign, readonly) NSInteger memory;

+ (instancetype)monitor;

+ (void)beginMonitorCPUUsage;

+ (void)endMonitorCPUUsage;


+ (void)beginMonitorFPS;

+ (void)endMonitorFPS;


+ (void)beginMonitorMemoryUsage;

+ (void)endMonitorMemoryUsage;


- (void)beginMonitorCaton;

- (void)endMonitorCaton;

- (NSString *)logString;

@end


NS_ASSUME_NONNULL_END
