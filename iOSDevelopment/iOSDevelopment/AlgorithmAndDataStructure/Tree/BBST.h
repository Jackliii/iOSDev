//
//  BBST.h
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/11.
//

#import "BinaryTree.h"
#import "Node.h"
#import "BinaryTreeInfo.h"

/**
 二叉搜索树
 */
@interface BST : BinaryTree <BinaryTreeInfo>

- (void)addNode:(NSInteger)value;

- (NSInteger)removeNode:(NSInteger)value;

- (BOOL)contains:(NSInteger)value;

- (void)afterAdd:(TreeNode *)node;

- (void)afterRemove:(TreeNode *)node;

- (TreeNode *)node:(NSInteger)value parent:(TreeNode *)parent;

@end

/**
 平衡二叉搜索树
 */
@interface BBST : BST

/**
 左旋
 */
- (void)rotateLeft:(TreeNode *)grand;

/**
 右旋
 */
- (void)rotateRight:(TreeNode *)grand;

/**
更新节点
 */
- (void)afterRotate:(TreeNode *)grand parent:(TreeNode *)parent child:(TreeNode *)child;

@end

