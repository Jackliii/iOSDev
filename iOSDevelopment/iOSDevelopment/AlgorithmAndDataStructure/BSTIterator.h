//
//  BSTIterator.h
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/9/9.
//

#import <Foundation/Foundation.h>
#import "Node.h"

NS_ASSUME_NONNULL_BEGIN

/**
 题目：请实现二叉搜索树的迭代器BSTIterator，它主要有如下3个函数。
 ● 构造函数：输入二叉搜索树的根节点初始化该迭代器。
 ● 函数next：返回二叉搜索树中下一个最小的节点的值。
 ● 函数hasNext：返回二叉搜索树是否还有下一个节点。
 */
@interface BSTIterator : NSObject

+ (instancetype)bstIterator:(TreeNode *)root;

- (BOOL)hasNext;

- (NSInteger)next;

@end

@interface BSTIteratorReversed : NSObject

+ (instancetype)bstIteratorReversed:(TreeNode *)root;

- (BOOL)hasPrev;

- (NSInteger)prev;

@end


NS_ASSUME_NONNULL_END
