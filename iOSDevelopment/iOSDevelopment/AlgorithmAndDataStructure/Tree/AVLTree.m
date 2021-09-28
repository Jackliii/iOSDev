//
//  AVLTree.m
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/11.
//

#import "AVLTree.h"

@implementation AVLTree

- (TreeNode *)node:(NSInteger)value parent:(TreeNode *)parent {
    return [AVLNode nodeWithValue:value parent:parent];
}

- (void)afterAdd:(TreeNode *)node {
    while ((node = node.parent) != nil) {
        if ([self isBalanced:node]) {
            [self updateHeight:node];
        } else {
            [self reBalance:node];
            break;
        }
    }
}

- (void)afterRemove:(TreeNode *)node {
    while ((node = node.parent) != nil) {
        if ([self isBalanced:node]) {
            [self updateHeight:node];
        } else {
            [self reBalance:node];
            break;
        }
    }
}

- (BOOL)isBalanced:(TreeNode *)node {
    return labs([(AVLNode *)node balanceFactor]) <= 1;
}

- (void)updateHeight:(TreeNode *)node {
    [(AVLNode *)node updateHeight];
}

/**
 恢复平衡
*/
- (void)reBalance:(TreeNode *)grand {
    AVLNode *avlNode = (AVLNode *)grand;
    AVLNode *parent = [avlNode tallerChild];
    AVLNode *node = [parent tallerChild];
    if ([parent isLeftChild]) {
        if ([node isLeftChild]) {//LL,简化了代码
//            [self rotateRight:grand];
        } else {//LR
            [self rotateLeft:parent];
//            [self rotateRight:grand];
        }
        [self rotateRight:grand];
    } else {
        if ([node isLeftChild]) {//RL
            [self rotateRight:parent];
//            [self rotateLeft:grand];
        } else {//RR
//            [self rotateLeft:grand];
        }
        [self rotateLeft:grand];
    }
}

- (void)afterRotate:(TreeNode *)grand parent:(TreeNode *)parent child:(TreeNode *)child {
    [super afterRotate:grand parent:parent child:child];
    [self updateHeight:grand];
    [self updateHeight:parent];
}

@end
