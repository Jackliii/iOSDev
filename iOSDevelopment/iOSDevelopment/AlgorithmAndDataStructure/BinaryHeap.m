//
//  BinaryHeap.m
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/13.
//

#import "BinaryHeap.h"

#define DEFAULT_CAPACITY 16

@interface BinaryHeap ()

@property (nonatomic, assign) NSUInteger size;

@property (nonatomic, strong) NSMutableArray *elements;

@end

@implementation BinaryHeap

+ (instancetype)heap {
    return [[BinaryHeap alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _size = 0;
        _elements = [NSMutableArray arrayWithCapacity:DEFAULT_CAPACITY];
    }
    return self;
}

- (NSUInteger)size {
    return _size;
}

- (BOOL)isEmpty {
    return _size == 0;
}

- (void)clear {
    [_elements removeAllObjects];
    _size = 0;
}

- (void)add:(NSInteger)value {
    [self ensureCapacity:_size + 1];
    _elements[_size++] = @(value);
    [self siftUp:_size - 1];
}

- (NSInteger)remove {
    [self emptyCheck];
    
    NSInteger lastIndex = --_size;
    NSInteger root = [_elements[0] integerValue];
    _elements[0] = _elements[lastIndex];
    [_elements removeObjectAtIndex:lastIndex];
    [self siftDown:0];
    return root;
}

- (NSInteger)getTop {
    return [_elements[0] integerValue];
}

- (NSInteger)replace:(NSInteger)value {
    NSInteger root = 0;
    if (_size == 0) {
        _elements[0] = @(value);
        _size++;
    } else {
        root = [_elements[0] integerValue];
        _elements[0] = @(value);
        [self siftDown:0];
    }
    return root;
}

- (void)siftUp:(NSUInteger)index {
    NSInteger elementD = [_elements[index] integerValue];
    NSInteger element = elementD;
    while (index > 0) {
        NSUInteger parentIndex = (index - 1) >> 1;
        NSInteger parentD = [_elements[parentIndex] integerValue];
        NSInteger parent = parentD;
        if ([self compareObj1:element obj2:parent] <= 0) {
            break;
        }
        _elements[index] = @(parentD);
        index = parentIndex;
    }
    _elements[index] = @(elementD);
}

- (void)siftDown:(NSUInteger)index {
    NSInteger element = [_elements[index] integerValue];
    NSUInteger half = _size >> 1;
    while (index < half) {
        NSUInteger childIndex = (index >> 1) + 1;
        NSInteger child = [_elements[childIndex] integerValue];

        NSUInteger rightIndex = childIndex + 1;
        if (rightIndex < _size && [self compareObj1:[_elements[rightIndex] integerValue] obj2:child] > 0) {
            child = [_elements[childIndex = rightIndex] integerValue];
        }
        if ([self compareObj1:element obj2:child] >= 0) {
            break;;
        }
        child = child;
        _elements[index] = @(child);
        index = childIndex;
    }
    _elements[index] = @(element);
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

- (void)heapify {
//    for (int i = 0; i < _size; i++) {
//        [self siftUp:i];
//    }
    for (NSUInteger i = ((_size >> 1) - 1); i >= 0; i--) {
        [self siftDown:i];
    }
}

- (void)ensureCapacity:(NSUInteger)capacity {
    NSUInteger oldCapacity = _elements.count;
    if (oldCapacity >= capacity) {
        return;
    }
    
    NSUInteger newCapacity = oldCapacity + (oldCapacity >> 1);
    NSMutableArray *newElements = [NSMutableArray arrayWithCapacity:newCapacity];
    for (int i = 0; i < oldCapacity; i++) {
        newElements[i] = _elements[i];
    }
    _elements = newElements;
}

- (void)emptyCheck {
    if (_size == 0) {
        @throw [NSException exceptionWithName:@"Index" reason:@"_size == 0" userInfo:nil];
    }
}

- (void)elementNotNullCheck {
    if (_size == 0) {
        @throw [NSException exceptionWithName:@"Index" reason:@"_size == 0" userInfo:nil];
    }
}

#pragma mark - BinaryTreeInfo
- (id)left:(id)node {
    NSInteger index = ([node integerValue] << 1) + 1;
    return index >= _size ? nil : @(index);
}

- (id)right:(id)node {
    NSInteger index = ([node integerValue] << 1) + 2;
    return index >= _size ? nil : @(index);
}

- (id)string:(id)node {
    NSInteger index = [node integerValue];
    return _elements[index];
}

- (id)rootNode {
    return 0;
}


@end
