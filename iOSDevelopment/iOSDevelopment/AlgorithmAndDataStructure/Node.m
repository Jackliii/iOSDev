//
//  Node.m
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/11.
//

#import "Node.h"

@implementation Node

+ (instancetype)node {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end

@implementation TreeNode

+ (instancetype)nodeWithValue:(NSInteger)value parent:(TreeNode *)parent {
    return [[self alloc] initWithValue:value parent:parent];
}

- (instancetype)initWithValue:(NSInteger)value parent:(TreeNode *)parent {
    if (self = [super init]) {
        self.value = value;
        self.parent = parent;
    }
    return self;
}

- (TreeNode *)grand {
    return self.parent.parent;
}

- (TreeNode *)invertTree:(TreeNode *)node {
    if (node == nil) {
        return node;
    }
    TreeNode *tmp = node.left;
    node.left = node.right;
    node.right = tmp;
    [self invertTree:node.left];
    [self invertTree:node.right];
    return node;
}

- (BOOL)isLeftChild {
    return _parent != nil && self == _parent.left;
}

- (BOOL)isRightChild {
    return _parent != nil && self == _parent.right;
}

- (TreeNode *)sibling {
    if ([self isLeftChild]) {
        return _parent.right;
    }
    if ([self isRightChild]) {
        return _parent.left;
    }
    return nil;
}

- (TreeNode *)uncle {
    return [_parent sibling];
}

- (BOOL)isLeaf {
    return self.left == nil && self.right == nil;
}

- (BOOL)hasTwoChildren {
    return self.left != nil && self.right != nil;
}


@end


@implementation LinkChildNode

@end

@implementation LinkedNode

+ (instancetype)nodePrev:(LinkedNode *)prev value:(NSInteger)value next:(LinkedNode *)next {
    return [[self alloc] initWithPrev:prev value:value next:next];
}

+ (instancetype)nodeValue:(NSInteger)value next:(LinkedNode *)next {
    return [[self alloc] initWithPrev:nil value:value next:next];
}

+ (instancetype)nodeValue:(NSInteger)value {
    LinkedNode *node = [[self alloc] init];
    if (node) {
        node.value = value;
    }
    return node;
}

- (instancetype)initWithPrev:(LinkedNode *)prev value:(NSInteger)value next:(LinkedNode *)next {
    if (self = [super init]) {
        _prev = prev;
        self.value = value;
        _next = next;
    }
    return self;
}


@end


@interface AVLNode ()

@end

@implementation AVLNode

- (instancetype)initWithValue:(NSInteger)value parent:(TreeNode *)parent {
    if (self = [super initWithValue:value parent:parent]) {
        _height = 1;
    }
    return self;
}

- (NSInteger)balanceFactor {
    AVLNode *left = (AVLNode *)self.left;
    AVLNode *right = (AVLNode *)self.right;
    NSInteger leftHeight = self.left == nil ? 0 : left.height;
    NSInteger rightHeight = self.right == nil ? 0 : right.height;
    return leftHeight - rightHeight;
}

- (void)updateHeight {
    AVLNode *left = (AVLNode *)self.left;
    AVLNode *right = (AVLNode *)self.right;
    NSInteger leftHeight = self.left == nil ? 0 : left.height;
    NSInteger rightHeight = self.right == nil ? 0 : right.height;
    self.height = 1 + MAX(leftHeight, rightHeight);
}

- (AVLNode *)tallerChild {
    AVLNode *left = (AVLNode *)self.left;
    AVLNode *right = (AVLNode *)self.right;
    NSInteger leftHeight = self.left == nil ? 0 : left.height;
    NSInteger rightHeight = self.right == nil ? 0 : right.height;
    if (leftHeight > rightHeight) {
        return left;
    }
    if (rightHeight > leftHeight) {
        return right;
    }
    return [self isLeftChild] ? left : right;
}

@end



@interface RBNode ()

//@property (nonatomic, assign) BOOL color;
//
@end

@implementation RBNode

- (instancetype)initWithValue:(NSInteger)value parent:(TreeNode *)parent {
    if (self = [super initWithValue:value parent:parent]) {
        _color = RED;
    }
    return self;
}

@end
