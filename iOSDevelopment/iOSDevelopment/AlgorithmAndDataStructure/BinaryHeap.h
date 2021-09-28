//
//  BinaryHeap.h
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/13.
//

#import <Foundation/Foundation.h>
#import "BinaryTreeInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface BinaryHeap : NSObject <BinaryTreeInfo>

+ (instancetype)heap;

- (NSUInteger)size;

- (BOOL)isEmpty;

- (void)clear;

- (void)add:(NSInteger)value;

- (NSInteger)remove;

- (NSInteger)getTop;

- (NSInteger)replace:(NSInteger)value;

@end

NS_ASSUME_NONNULL_END
