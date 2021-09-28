//
//  Monitor.m
//  iOSDevelopment
//
//  Created by 大明 on 2021/9/23.
//

#import "Monitor.h"
#import <mach/task.h>
#import <mach/mach_init.h>
#import <mach/thread_act.h>
#import <mach/vm_map.h>
#import <mach/task_info.h>

@interface Monitor ()

@end

@implementation Monitor

+ (void)updateCPU {
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

+ (float)currentCPUUsage {
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


+ (NSUInteger)memoryUsage {
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
+ (NSUInteger)memoryUsage1 {
  struct mach_task_basic_info vmInfo;
    mach_msg_type_number_t size = sizeof(vmInfo);
    kern_return_t kr = task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)&vmInfo, &size);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    return vmInfo.resident_size;
}

@end
