//
//  RedBlackTree.m
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/11.
//

#import "RedBlackTree.h"

@implementation RedBlackTree

- (TreeNode *)node:(NSInteger)value parent:(TreeNode *)parent {
    return [RBNode nodeWithValue:value parent:parent];
}

- (void)afterAdd:(TreeNode *)node {
    TreeNode *parent = node.parent;
    if (parent == nil) {
        [self black:node];
        return;
    }
    
    if ([self isBlack:parent]) return;
    
    TreeNode *uncle = [parent sibling];
    TreeNode *grand = [self red:parent.parent];
    if ([self isRed:uncle]) {
        [self black:parent];
        [self black:uncle];
        [self afterAdd:[self red:grand]];
        return;
    }
    
    if ([parent isLeftChild]) {
        if ([node isLeftChild]) {//LL
            //父节点染黑，祖父节点（grand）染红（前面代码已经操作）
            [self black:parent];
        } else {//LR
            [self black:node];
            [self rotateLeft:parent];
        }
        [self rotateRight:grand];
    } else {
        if ([node isLeftChild]) {//RL
            [self black:node];
            [self rotateRight:parent];
//            [self rotateLeft:grand];
        } else {//RR
            [self black:parent];
//            [self rotateLeft:grand];
        }
        [self rotateLeft:grand];
    }
}

- (void)afterRemove:(TreeNode *)node {
    if ([self isRed:node]) {
        [self black:node];
        return;
    }
    
    TreeNode *parent = node.parent;
    if (parent == nil) return;
    
    BOOL left = parent.left == nil || [node isLeftChild];
    TreeNode *sibling = left ? parent.right : parent.left;
    if (left) {
        if ([self isRed:sibling]) {
            [self black:sibling];
            [self red:parent];
            [self rotateLeft:parent];
            sibling = parent.right;
        }
        
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            if (parentBlack) {
                [self afterRemove:parent];
            }
        } else {
            if ([self isBlack:sibling.right]) {
                [self rotateRight:sibling];
                sibling = parent.right;
            }
            [self color:sibling color:[self colorOf:parent]];
            [self black:sibling.right];
            [self black:parent];
            [self rotateLeft:parent];
        }
    } else {
        if ([self isRed:sibling]) {
            [self black:sibling];
            [self red:parent];
            [self rotateRight:parent];
            sibling = parent.left;
        }
        
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            if (parentBlack) {
                [self afterRemove:parent];
            }
        } else {
            if ([self isBlack:sibling.left]) {
                [self rotateLeft:sibling];
                sibling = parent.left;
            }
            [self color:sibling color:[self colorOf:parent]];
            [self black:sibling.left];
            [self black:parent];
            [self rotateRight:parent];
        }
    }
}

- (TreeNode *)color:(TreeNode *)node color:(BOOL)color {
    if (node == nil) return node;
    RBNode *rbNode = (RBNode *)node;
    rbNode.color = color;
    return rbNode;
}

- (TreeNode *)red:(TreeNode *)node {
    return [self color:node color:RED];
}

- (TreeNode *)black:(TreeNode *)node {
    return [self color:node color:BLACK];
}

- (BOOL)isRed:(TreeNode *)node {
    return [self colorOf:node] == RED;
}

- (BOOL)isBlack:(TreeNode *)node {
    return [self colorOf:node] == BLACK;
}

- (BOOL)colorOf:(TreeNode *)node {
    RBNode *rbNode = (RBNode *)node;
    return node == nil ? BLACK : rbNode.color;
}

- (id)string:(RBNode *)node {
    NSString *str = node.color == RED ? @"R" : @"B";
    return [NSString stringWithFormat:@"%ld-%@", (long)node.value, str];
}

@end
