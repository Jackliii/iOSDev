//
//  BinaryTree.h
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/11.
//

#import <Foundation/Foundation.h>
#import "Node.h"


@interface BinaryTree : NSObject

@property (nonatomic, strong) TreeNode *root;

+ (instancetype)tree;

- (NSUInteger)size;

- (BOOL)isEmpty;

- (void)clear;

/**
 判断是否为完全二叉树
 */
- (BOOL)isComplete;

/**
 前序遍历
 */
- (void)preorderTraversal;
/**
 中序遍历
 */
- (void)inorderTraversal;
/**
 后序遍历
 */
- (void)postorderTraversal;
/**
 层序遍历
 */
- (void)levelOrderTraversal;

/**
 树高
 */
- (NSUInteger)treeHeight;

/**
 前驱节点：中序遍历时的前一个节点
 */
- (TreeNode *)predecessor:(TreeNode *)node;

/**
 后继节点：中序遍历时的后一个节点
 */
- (TreeNode *)successor:(TreeNode *)node;

@end

