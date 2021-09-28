//
//  BinaryTree.m
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/11.
//

#import "BinaryTree.h"

@interface BinaryTree ()

@property (nonatomic, assign) NSUInteger size;

@end

@implementation BinaryTree

- (NSUInteger)size {
    return _size;
}

- (BOOL)isEmpty {
    return _size == 0;
}

+ (instancetype)tree {
    return [[self alloc] init];
}

- (BOOL)isComplete {
    if (self.root == nil) {
        return NO;
    }
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:self.root];
    BOOL leaf = NO;
    while (arr.count > 0) {
        TreeNode *node = arr[0];
        [arr removeObject:node];
        if (leaf && ![node isLeaf]) {
            return NO;
        }
        
        if (node.left != nil) {
            [arr addObject:node.left];
        } else if (node.right != nil) {
            return NO;
        }
        
        if (node.right != nil) {
            [arr addObject:node.right];
        } else {
            leaf = YES;
        }
    }
    return YES;
}

- (void)clear {
    self.root = nil;
    _size = 0;
}

- (NSUInteger)treeHeight {
    return [self treeHeight:self.root];
}

- (NSInteger)treeHeight:(TreeNode *)node {
    if (node == nil) return 0;
    return 1 + MAX([self treeHeight:node.left], [self treeHeight:node.right]);
}

- (NSInteger)treeHeight2:(TreeNode *)node {
    if (self.root == nil) {
        return 0;
    }
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:self.root];
    
    NSUInteger height = 0;
    NSUInteger levelSize = 1;
    while (arr.count > 0) {
        TreeNode *node = arr[0];
        [arr removeObject:node];
        levelSize--;
        if (node.left != nil) {
            [arr addObject:node.left];
        }
        if (node.right != nil) {
            [arr addObject:node.right];
        }
        if (levelSize == 0) {
            levelSize = arr.count;
            height++;
        }
    }
    return height;
}

- (void)inorderTraversal {
    [self inorderTraversal1:self.root];
}

- (void)inorderTraversal:(TreeNode *)node {
    if (node == nil) return;
    [self inorderTraversal:node.left];
    NSLog(@"%ld", (long)node.value);
    [self inorderTraversal:node.right];
}

- (void)preorderTraversal {
    [self preorderTraversal1:self.root];
}

- (void)preorderTraversal:(TreeNode *)node {
    if (node == nil) return;
    NSLog(@"%ld", (long)node.value);
    [self inorderTraversal:node.left];
    [self inorderTraversal:node.right];
}

- (void)postorderTraversal {
    [self postorderTraversal1:self.root];
}

- (void)postorderTraversal:(TreeNode *)node {
    if (node == nil) return;
    [self inorderTraversal:node.left];
    [self inorderTraversal:node.right];
    NSLog(@"%ld", (long)node.value);
}

- (void)inorderTraversal1:(TreeNode *)node {
    if (node == nil) return;
    TreeNode *n = node;
    NSMutableArray *arr = [NSMutableArray array];
    
    while (YES) {
        if (n != nil) {
            [arr addObject:n];
            n = n.left;
        } else if (arr.count < 1) {
            return;
        } else {
            n = [arr lastObject];
            NSLog(@"-----%ld", (long)n.value);

            [arr removeLastObject];
            n = n.right;
        }
    }
}

- (void)preorderTraversal1:(TreeNode *)node {
    if (node == nil) return;
    TreeNode *n = node;
    NSMutableArray *arr = [NSMutableArray array];
    while (YES) {
        if (n != nil) {
            NSLog(@"-----%ld", (long)n.value);

            if (n.right != nil) {
                [arr addObject:n.right];
            }
            n = n.left;
        } else if (arr.count < 1) {
            return;
        } else {
            n = [arr lastObject];
            [arr removeLastObject];
        }
    }
}

- (void)postorderTraversal1:(TreeNode *)node {
    if (node == nil) return;
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:node];
    TreeNode *prev = nil;

    while (arr.count > 0) {
        TreeNode *n = [arr lastObject];
        if ([n isLeaf] || (prev != nil && prev.parent == n)) {
           prev = [arr lastObject];
            [arr removeLastObject];
            NSLog(@"-----%ld", (long)prev.value);

        } else {
            if (n.right != nil) {
                [arr addObject:n.right];
            }
            if (n.left != nil) {
                [arr addObject:n.left];
            }
        }
    }
}

/**
 前驱节点：中序遍历时的前一个节点
 */
- (TreeNode *)predecessor:(TreeNode *)node {
    if (node == nil) return node;
    TreeNode *n = node.left;
    if (n != nil) {
        while (n.right != nil) {
            n = n.right;
        }
        return n;
    }
    while (node.parent != nil && node == node.parent.left) {
        node = node.parent;
    }
    return node.parent;
}

/**
 后继节点：中序遍历时的后一个节点
 */
- (TreeNode *)successor:(TreeNode *)node {
    if (node == nil) return node;
    TreeNode *n = node.right;
    if (n != nil) {
        while (n.left != nil ) {
            n = n.left;
        }
        return n;
    }
    while (node.parent != nil && node == node.parent.right) {
        node = node.parent;
    }
    return node.parent;
}

- (void)levelOrderTraversal {
    if (self.root == nil) {
        return;
    }
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:self.root];
    
    while (arr.count > 0) {
        TreeNode *node = arr[0];
        NSLog(@"%ld", (long)node.value);
        [arr removeObject:node];
        if (node.left != nil) {
            [arr addObject:node.left];
        }
        if (node.right != nil) {
            [arr addObject:node.right];
        }
    }
}

@end
