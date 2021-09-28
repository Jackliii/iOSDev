//
//  BSTIterator.m
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/9/9.
//

#import "BSTIterator.h"

@interface BSTIterator ()

@property (nonatomic, strong) TreeNode *cur;

@property (nonatomic, strong) NSMutableArray *stack;

@end

@implementation BSTIterator

+ (instancetype)bstIterator:(TreeNode *)root {
    BSTIterator *bst = [[BSTIterator alloc] init];
    bst.cur = root;
    return bst;
}

- (instancetype)init {
    if (self = [super init]) {
        _stack = [NSMutableArray array];
    }
    return self;
}

- (BOOL)hasNext {
    return _cur != nil && _stack.count > 0;
}

- (NSInteger)next {
    while (_cur != nil) {
        [_stack addObject:_cur];
        _cur = _cur.left;
    }
    _cur = [_stack lastObject];
    [_stack removeLastObject];
    NSInteger v = _cur.value;
    _cur = _cur.right;
    return v;
}

@end


@interface BSTIteratorReversed ()

@property (nonatomic, strong) TreeNode *cur;

@property (nonatomic, strong) NSMutableArray *stack;

@end

@implementation BSTIteratorReversed

+ (instancetype)bstIteratorReversed:(TreeNode *)root {
    BSTIteratorReversed *bst = [[BSTIteratorReversed alloc] init];
    bst.cur = root;
    return bst;
}

- (instancetype)init {
    if (self = [super init]) {
        _stack = [NSMutableArray array];
    }
    return self;
}

- (BOOL)hasPrev {
    return _cur != nil && _stack.count > 0;
}

- (NSInteger)prev {
    while (_cur != nil) {
        [_stack addObject:_cur];
        _cur = _cur.right;
    }
    _cur = [_stack lastObject];
    [_stack removeLastObject];
    NSInteger v = _cur.value;
    _cur = _cur.left;
    return v;
}

@end
