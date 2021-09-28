//
//  MonitorCore.m
//  iOSDevelopment
//
//  Created by 大明 on 2021/9/23.
//

#import "MonitorCore.h"
#import "WeakProxy.h"
#import <mach/task.h>
#import <mach/mach_init.h>
#import <mach/thread_act.h>
#import <mach/vm_map.h>
#import <mach/task_info.h>
#import "Common.h"
#import <UIKit/UIKit.h>

@interface MonitorCore (){
    dispatch_semaphore_t dispatchSemaphore;
    CFRunLoopObserverRef runLoopObserver;
    CFRunLoopActivity runLoopActivity;
    int timeoutCount;
}

@property (nonatomic, assign, readwrite) NSInteger fps;

@property (nonatomic, assign, readwrite) NSInteger cpu;

@property (nonatomic, assign, readwrite) NSInteger memory;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL monitorCPU;

@property (nonatomic, assign) BOOL monitorMemory;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) long lastTimeStamp;

@end

@implementation MonitorCore

+ (instancetype)monitor {
    static MonitorCore *monitor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[MonitorCore alloc] init];
    });
    return monitor;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

+ (void)beginMonitorMemoryUsage {
    [MonitorCore monitor].monitorMemory = YES;
    if ([MonitorCore monitor].timer) {
    } else {
        [MonitorCore monitor].timer = [NSTimer scheduledTimerWithTimeInterval:2 target:[WeakProxy proxyWithTarget:[MonitorCore monitor]] selector:@selector(monitorUsage) userInfo:nil repeats:YES];
    }
}

- (void)monitorUsage {
    if (_monitorCPU) {
        [self monitorCPUUsage];
    }
    if (_monitorMemory) {
        [self monitorMemoryUsage];
    }
}

+ (void)endMonitorMemoryUsage {
    [MonitorCore monitor].monitorMemory = NO;
    if ([MonitorCore monitor].monitorCPU == NO) {
        [[MonitorCore monitor].timer invalidate];
        [MonitorCore monitor].timer = nil;
    }
}

- (void)monitorMemoryUsage {
    _memory = [self memoryUsage] / 1024 / 1024;
//    NSLog(@"内存：%ld", _memory);
}

+ (void)beginMonitorCPUUsage {
    [MonitorCore monitor].monitorCPU = YES;
    if ([MonitorCore monitor].timer) {
    } else {
        [MonitorCore monitor].timer = [NSTimer scheduledTimerWithTimeInterval:2 target:[WeakProxy proxyWithTarget:[MonitorCore monitor]] selector:@selector(monitorUsage) userInfo:nil repeats:YES];
    }
}

+ (void)endMonitorCPUUsage {
    [MonitorCore monitor].monitorCPU = NO;
    if ([MonitorCore monitor].monitorMemory == NO) {
        [[MonitorCore monitor].timer invalidate];
        [MonitorCore monitor].timer = nil;
    }
}

- (void)monitorCPUUsage {
//    [self updateCPU];
    _cpu = [self currentCPUUsage];
}

+ (void)beginMonitorFPS {
    [MonitorCore monitor].displayLink = [CADisplayLink displayLinkWithTarget:[WeakProxy proxyWithTarget:[MonitorCore monitor]] selector:@selector(fpsCount:)];
    [[MonitorCore monitor].displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

+ (void)endMonitorFPS {
    [[MonitorCore monitor].displayLink invalidate];
    [MonitorCore monitor].displayLink = nil;
}

long total;
- (void)fpsCount:(CADisplayLink *)link {
    if (_lastTimeStamp == 0) {
        _lastTimeStamp = self.displayLink.timestamp;
    } else {
        total++;
        NSTimeInterval useTime = self.displayLink.timestamp - _lastTimeStamp;
        if (useTime < 1) {
            return;
        }
        _lastTimeStamp = self.displayLink.timestamp;
        _fps = total / useTime;
        NSLog(@"FPS:%ld", (long)_fps);
        total = 0;
    }
}

- (void)beginMonitorCaton {
    if (runLoopObserver) {
        return;
    }
    dispatchSemaphore = dispatch_semaphore_create(0);
    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL};
    runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runLoopObserverCallBack, &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES) {
            /**
             SEC   秒
             PER   每
             NSEC 纳秒
             MSEC 毫秒
             USEC 微秒
             */
            long semaphoreWait = dispatch_semaphore_wait(self->dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, 30*NSEC_PER_MSEC));
            if (semaphoreWait != 0) {
                if (!self->runLoopObserver) {
                    self->timeoutCount = 0;
                    self->dispatchSemaphore = 0;
                    self->runLoopActivity = 0;
                    return;
                }
                //两个runloop的状态，BeforeSources和AfterWaiting这两个状态区间时间能够检测到是否卡顿
                if (self->runLoopActivity == kCFRunLoopBeforeSources || self->runLoopActivity == kCFRunLoopAfterWaiting) {
                    if (++self->timeoutCount < 3) {
                        continue;
                    }
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                        NSLog(@"检测到卡顿问题");
                    });
                }
            }
            self->timeoutCount = 0;
        }
    });
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    MonitorCore *rl = (__bridge MonitorCore *)(info);
    rl->runLoopActivity = activity;
    dispatch_semaphore_t semaphore = rl->dispatchSemaphore;
    dispatch_semaphore_signal(semaphore);
    if (activity == kCFRunLoopEntry) {  // 即将进入RunLoop
        NSLog(@"runLoopObserverCallBack - %@",@"kCFRunLoopEntry");
    } else if (activity == kCFRunLoopBeforeTimers) {    // 即将处理Timer
        NSLog(@"runLoopObserverCallBack - %@",@"kCFRunLoopBeforeTimers");
    } else if (activity == kCFRunLoopBeforeSources) {   // 即将处理Source
        NSLog(@"runLoopObserverCallBack - %@",@"kCFRunLoopBeforeSources");
    } else if (activity == kCFRunLoopBeforeWaiting) {   //即将进入休眠
        NSLog(@"runLoopObserverCallBack - %@",@"kCFRunLoopBeforeWaiting");
    } else if (activity == kCFRunLoopAfterWaiting) {    // 刚从休眠中唤醒
        NSLog(@"runLoopObserverCallBack - %@",@"kCFRunLoopAfterWaiting");
    } else if (activity == kCFRunLoopExit) {    // 即将退出RunLoop
        NSLog(@"runLoopObserverCallBack - %@",@"kCFRunLoopExit");
    } else if (activity == kCFRunLoopAllActivities) {
        NSLog(@"runLoopObserverCallBack - %@",@"kCFRunLoopAllActivities");
    }
}

- (void)endMonitorCaton {
    if (!runLoopObserver) {
        return;;
    }
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    CFRelease(runLoopObserver);
    runLoopObserver = NULL;
}

- (void)updateCPU {
    thread_act_array_t threads;
    mach_msg_type_number_t threadCount = 0;
    const task_t thisTask = mach_task_self();
    kern_return_t kr = task_threads(thisTask, &threads, &threadCount);
    if (kr != KERN_SUCCESS) {
        return;
    }
    for (int i = 0; i < threadCount; i++) {
        thread_info_data_t threadInfo;
        thread_basic_info_t threadBaseInfo;
        mach_msg_type_number_t threadInfoCount = THREAD_INFO_MAX;
        kr = thread_info((thread_act_t)threads[i], THREAD_BASIC_INFO, (thread_info_t)threadInfo, &threadInfoCount);
        if (kr != KERN_SUCCESS) {
            return;
        }
        threadBaseInfo = (thread_basic_info_t)threadInfo;
        if (!(threadBaseInfo->flags & TH_FLAGS_IDLE)) {
            integer_t cpuUsage = threadBaseInfo->cpu_usage / 10;
            _cpu = cpuUsage;
            if (cpuUsage > 70) {
                //cup 消耗大于 70 时打印和记录堆栈
               //NSString *reStr = smStackOfThread(threads[i]);
                //记录数据库中
                NSLog(@"-----CPU useage overload thread stack：\n%d",cpuUsage);
            } else {
                NSLog(@"CPU useage：%d",cpuUsage);
            }
        }
    }
}

- (float)currentCPUUsage {
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    thread_array_t thread_list;
    mach_msg_type_number_t thread_count;
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    float tot_cpu = 0;
    for (int i = 0; i < thread_count; i++) {
        thread_info_data_t thinfo;
        mach_msg_type_number_t thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[i], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        thread_basic_info_t basic_info_th = (thread_basic_info_t)thinfo;
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
    }
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    return tot_cpu;
}

- (NSUInteger)memoryUsage {
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kr = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t)&vmInfo, &count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    return vmInfo.phys_footprint;
}

/**
 通常情况下，我们在获取 iOS 应用内存使用量时，都是使用 task_basic_info 里的 resident_size 字段信息。但是，我们发现这样获得的内存使用量和 Instruments 里看到的相差很大。后来，在 2018 WWDC Session 416 iOS Memory Deep Dive("https://developer.apple.com/videos/play/wwdc2018/416/")中，苹果公司介绍说 phys_footprint 才是实际使用的物理内存。
 内存信息存在 task_info.h （完整路径 usr/include/mach/task.info.h）文件的 task_vm_info 结构体中，其中 phys_footprint 就是物理内存的使用，而不是驻留内存 resident_size。
 */
- (NSUInteger)memoryUsage1 {
  struct mach_task_basic_info vmInfo;
    mach_msg_type_number_t size = sizeof(vmInfo);
    kern_return_t kr = task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)&vmInfo, &size);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    return vmInfo.resident_size;
}

- (NSString *)logString {
    return [NSString stringWithFormat:@"FPS:%ld   内存使用:%ldMB   CPU占用:%ld", (long)self.fps, (long)self.memory, (long)self.cpu];
}

@end

