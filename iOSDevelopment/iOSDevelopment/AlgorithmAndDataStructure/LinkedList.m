//
//  LinkedList.m
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/11.
//

#import "LinkedList.h"

@interface LinkedList ()

@property (nonatomic, assign) NSUInteger size;

@end

@implementation LinkedList

+ (instancetype)list {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _size = 0;
    }
    return self;
}

- (void)addNode:(NSInteger)value index:(NSUInteger)index {
    [self rangeCheckForAdd:index];
    if (index == 0) {
        _first = [LinkedNode nodeValue:value next:self.first];
    } else {
        LinkedNode *prev = [self nodeAtIndex:index - 1];
        prev.next = [LinkedNode nodeValue:value next:prev.next];
    }
    _size++;
}

- (NSInteger)removeNode:(NSUInteger)index {
    [self rangeCheck:index];
    NSInteger value = self.first.value;
    if (index == 0) {
        self.first = self.first.next;
    } else {
        LinkedNode *prev = [self nodeAtIndex:index - 1];
        value = prev.next.value;
        prev.next = prev.next.next;
    }
    _size--;
    return value;
}

- (void)clearLinkedList {
    _size = 0;
    _first = nil;
}

- (NSUInteger)count {
    return _size;
}

- (LinkedNode *)nodeAtIndex:(NSUInteger)index {
    [self rangeCheck:index];
    LinkedNode *node = self.first;
    for (int i = 0; i < index; i++) {
        node = node.next;
    }
    return node;
}

- (LinkedNode *)reverseLinkedList:(LinkedNode *)head {
    if (head == nil || head.next == nil) {
        return head;
    }
    LinkedNode *node = nil;
    while (head != nil) {
        LinkedNode *tmp = head.next;
        head.next = node;
        node = head;
        head = tmp;
    }
    return node;
}

- (LinkedNode *)reverseLinkedList1:(LinkedNode *)head {
    if (head.next == nil) {
        return head;
    }
    LinkedNode *node = [self reverseLinkedList1:head.next];
    head.next.next = head;
    head.next = nil;
    return node;
}

- (BOOL)hasCycle:(LinkedNode *)head {
    if (head == nil || head.next == nil) return NO;
    LinkedNode *slow = head;
    LinkedNode *fast = head.next;
    //为什么
    while (fast != nil && fast.next != nil) {
        slow = slow.next;
        fast = fast.next.next;
        if (slow == fast) return YES;
    }
    return NO;
}

- (void)rangeCheckForAdd:(NSInteger)index {
    if (index > self.size || index < 0) {
        @throw [NSException exceptionWithName:@"Index" reason:@"下标越界" userInfo:nil];
    }
}

- (void)rangeCheck:(NSInteger)index {
    if (index >= self.size || index < 0) {
        @throw [NSException exceptionWithName:@"Index" reason:@"下标越界" userInfo:nil];
    }
}

@end


@implementation DoublyLinkedList

- (void)addNode:(NSInteger)value index:(NSUInteger)index {
    [self rangeCheckForAdd:index];
    if (index == self.size) {//最后一个位置添加元素
        LinkedNode *oldLast = self.last;
        self.last = [LinkedNode nodePrev:oldLast value:value next:nil];
        if (oldLast == nil) {//链表没有元素
            self.first = self.last;
        } else {
            oldLast.next = self.last;
        }
    } else {
        LinkedNode *node = [self nodeAtIndex:index];
        LinkedNode *prev = node.prev;
        LinkedNode *newNode = [LinkedNode nodePrev:prev value:value next:node];
        node.prev = newNode;
        if (prev == nil) {
            self.first = newNode;
        } else {
            prev.next = newNode;
        }
    }
    self.size++;
}

- (NSInteger)removeNode:(NSUInteger)index {
    [self rangeCheck:index];
    LinkedNode *delNode = [self nodeAtIndex:index];
    LinkedNode *next = delNode.next;
    LinkedNode *prev = delNode.prev;
    if (prev == nil) {//删除第一个节点
        self.first = next;
    } else {
        prev.next = next;
    }
    if (next == nil) {//删除最后一个节点
        self.last = prev;
    } else {
        next.prev = prev;
    }
    return delNode.value;
}

- (LinkedNode *)nodeAtIndex:(NSUInteger)index {
    [self rangeCheck:index];
    if (index > (self.size >> 1)) {
        LinkedNode *node = self.last;
        for (NSInteger i = self.size - 1; i > index; i--) {
            node = node.prev;
        }
        return node;
    }
    LinkedNode *node = self.first;
    for (NSInteger i = 0; i < index; i++) {
        node = node.next;
    }
    return node;
}

- (void)clearLinkedList {
    LinkedNode *node = self.first;
    for (NSInteger i = 0; i < self.size; i++) {
        node.next = nil;
    }
    self.size = 0;
    self.first = nil;
    self.last = nil;
}

@end
