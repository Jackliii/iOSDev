//
//  BBST.m
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/11.
//

#import "BBST.h"

@interface BST ()

@property (nonatomic, assign) NSUInteger size;

@end

@implementation BST

- (BOOL)contains:(NSInteger)value {
    return NO;
}

- (NSUInteger)size {
    return _size;
}

- (TreeNode *)node:(NSInteger)value parent:(TreeNode *)parent {
    return [TreeNode nodeWithValue:value parent:parent];
}

- (void)addNode:(NSInteger)value {
    if (self.root == nil) {
        self.root = [self node:value parent:nil];
        self.size++;
        [self afterAdd:self.root];
        return;
    }
    TreeNode *node = self.root;
    TreeNode *parent = self.root;
    NSInteger cmp = 0;
    while (node != nil) {
        cmp = [self compareObj1:value obj2:node.value];
        parent = node;
        if (cmp > 0) {
            node = node.right;
        } else if (cmp < 0) {
            node = node.left;
        } else {
            node.value = value;
            return;
        }
    }
    //找到了新添加节点的父节点
    TreeNode *newNode = [self node:value parent:parent];
    if (cmp > 0) {
        parent.right = newNode;
    } else {
        parent.left = newNode;
    }
    [self afterAdd:newNode];
    _size++;
}

- (NSInteger)removeNode:(NSInteger)value {
    return [self remove:[self nodeWithValue:value]].value;
}

- (TreeNode *)remove:(TreeNode *)node {
    if (node == nil) return node;
    _size--;
    if ([node hasTwoChildren]) {
        TreeNode *n = [self successor:node];
        node.value = n.value;
        node = n;
    }
    TreeNode *replacement = node.left != nil ? node.left : node.right;
    if (replacement != nil) {
        replacement.parent = node.parent;
        if (node.parent == nil) {
            self.root = replacement;
        } else if (node == node.parent.left) {
            node.parent.left = replacement;
        } else if (node == node.parent.right) {
            node.parent.right = replacement;
        }
        [self afterRemove:replacement];
    } else if (node.parent == nil) {
        self.root = nil;
        [self afterRemove:node];
    } else {
        if (node == node.parent.left) {
            node.parent.left = nil;
        } else {
            node.parent.right = nil;
        }
        [self afterRemove:node];
    }
    return node;
}

- (TreeNode *)nodeWithValue:(NSInteger)value {
    TreeNode *node = self.root;
    while (node != nil) {
        NSInteger cmp = [self compareObj1:value obj2:node.value];
        if (cmp == 0) {
            return node;
        }
        if (cmp > 0) {
            node = node.right;
        } else {
            node = node.left;
        }
    }
    return nil;
}

- (NSInteger)compareObj1:(NSInteger)obj1 obj2:(NSInteger)obj2 {
    if (obj1 > obj2) {
        return 1;
    }
    if (obj1 == obj2) {
        return 0;
    }
    return -1;
}


- (void)afterAdd:(TreeNode *)node {
    
}

- (void)afterRemove:(TreeNode *)node {
    
}

#pragma mark - BinaryTreeInfo
- (id)left:(TreeNode *)node {
    return node.left;
}

- (id)right:(TreeNode *)node {
    return node.right;
}

- (id)string:(TreeNode *)node {
    return [NSString stringWithFormat:@"%ld", (long)node.value];
}

- (id)rootNode {
    return self.root;
}

@end


@implementation BBST

- (void)rotateLeft:(TreeNode *)grand {
    TreeNode *parent = grand.right;
    TreeNode *child = parent.left;
    grand.right = child;
    parent.left = grand;
    [self afterRotate:grand parent:parent child:child];
}

- (void)rotateRight:(TreeNode *)grand {
    TreeNode *parent = grand.left;
    TreeNode *child = parent.right;
    grand.left = child;
    parent.right = grand;
    [self afterRotate:grand parent:parent child:child];
}

- (void)afterRotate:(TreeNode *)grand parent:(TreeNode *)parent child:(TreeNode *)child {
    parent.parent = grand.parent;
    
    if ([grand isLeftChild]) {
        grand.parent.left = parent;
    } else if ([grand isRightChild]) {
        grand.parent.right = parent;
    } else {
        self.root = parent;
    }
    
    if (child) {
        child.parent = grand;
    }
    grand.parent = parent;
}

@end
