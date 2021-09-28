//
//  LRUCache.h
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/9/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRUCache : NSObject

+ (instancetype)cache;

- (void)setCacheCapacity:(NSInteger)capacity;

- (NSInteger)get:(NSInteger)key;

- (void)put:(NSInteger)key value:(NSInteger)value;

@end

NS_ASSUME_NONNULL_END
