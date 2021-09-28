//
//  LRUCache.m
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/9/7.
//

#import "LRUCache.h"
#import "Node.h"

@interface LRUCacheNode : LinkedNode

@property (nonatomic, assign) NSInteger key;

@end

@implementation LRUCacheNode

+ (instancetype)nodeValue:(NSInteger)value key:(NSInteger)key {
    LRUCacheNode *node = [[self alloc] init];
    if (node) {
        node.value = value;
        node.key = key;
    }
    return node;
}

@end

#define DefaultCapacity 4

@interface LRUCache ()

@property (nonatomic, strong) NSMutableDictionary *dict;

@property (nonatomic, assign) NSInteger capacity;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, strong) LRUCacheNode *head;

@property (nonatomic, strong) LRUCacheNode *tail;

@end

@implementation LRUCache

+ (instancetype)cache {
    return [[LRUCache alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _dict = [NSMutableDictionary dictionary];
        _capacity = DefaultCapacity;
        _size = 0;
        _head = [LRUCacheNode nodeValue:-1 key:-1];
        _tail = [LRUCacheNode nodeValue:-1 key:-1];
        _head.next = _tail;
        _tail.prev = _head;
    }
    return self;
}

- (void)setCacheCapacity:(NSInteger)capacity {
    _capacity = capacity;
    if (_capacity <= 0) {
        _capacity = DefaultCapacity;
    }
}

- (NSInteger)get:(NSInteger)key {
    LRUCacheNode *node = [_dict objectForKey:[self stringFromInteger:key]];
    if (node == nil) {
        return -1;
    }
    [self moveToTail:node value:node.value];
    return node.value;
}

- (void)moveToTail:(LRUCacheNode *)node value:(NSInteger)value {
    [self deleteNode:node];
    node.value = value;
    [self insertToTail:node];
}

- (void)deleteNode:(LRUCacheNode *)node {
    node.prev.next = node.next;
    node.next.prev = node.prev;
    _size--;
}

- (void)insertToTail:(LRUCacheNode *)node {
    _tail.prev.next = node;
    node.prev = _tail.prev;
    node.next = _tail;
    _tail.prev = node;
    _size++;
}

- (NSString *)stringFromInteger:(NSInteger)v {
    return [NSString stringWithFormat:@"%ld", (long)v];
}

- (void)put:(NSInteger)key value:(NSInteger)value {
    if ([[_dict allKeys] containsObject:[self stringFromInteger:key]]) {
        [self moveToTail:[_dict objectForKey:[self stringFromInteger:key]] value:value];
    } else {
        if (_size == _capacity) {
            LRUCacheNode *node = (LRUCacheNode *)_head.next;
            [self deleteNode:node];
            [_dict removeObjectForKey:[self stringFromInteger:node.key]];
        }
        LRUCacheNode *node = [LRUCacheNode nodeValue:value key:key];
        [_dict setObject:node forKey:[self stringFromInteger:key]];
        [self insertToTail:node];
    }
}

@end
