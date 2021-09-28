//
//  LinkedList.h
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/11.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface LinkedList : NSObject

@property (nonatomic, strong) LinkedNode *first;

@property (nonatomic, strong) LinkedNode *last;

- (void)addNode:(NSInteger)value index:(NSUInteger)index;

- (NSInteger)removeNode:(NSUInteger)index;

- (NSUInteger)count;

- (void)clearLinkedList;

+ (instancetype)list;

/**
 给定头节点，反转链表，返回新的头节点
 */
- (LinkedNode *)reverseLinkedList:(LinkedNode *)head;

- (LinkedNode *)reverseLinkedList1:(LinkedNode *)head;

@end

/**
双向链表
*/
@interface DoublyLinkedList : LinkedList


@end

