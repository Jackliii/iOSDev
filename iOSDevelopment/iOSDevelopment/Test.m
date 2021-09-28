//
//  Test.m
//  iOSDevelopment
//
//  Created by 大明 on 2021/9/23.
//

#import "Test.h"
#import "LinkedList.h"
#import "BinaryTrees.h"
#import "AVLTree.h"
#import "RedBlackTree.h"
#import "BinaryHeap.h"
#import "Algorithm.h"
#import "LRUCache.h"
#import <objc/objc.h>

@interface Test ()

@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation Test

+ (void)test {
    //    NSObject *obj = [[NSObject alloc] init];
    //    self.wObj = obj;
    //    __weak NSObject *m = _wObj;
    //    NSLog(@"%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(obj)));//打印1没毛病
    //    NSLog(@"%ld", (long)CFGetRetainCount((__bridge CFTypeRef)([[NSObject alloc] init])));//因为这个方法接受了一个参数，所以就有一个指针指向他，所以打印1
    //    NSLog(@"%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(_wObj)));//weak指针在他自己来看是引用计数多了1，是因为他也是个指向。但是在别的指针来看是没变的还是1
    //    NSLog(@"%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(m)));//weak指针在他自己来看是引用计数多了1，是因为他也是个指向。但是他也是看不到别的弱指针的指向的，所以他只能拿到强指针的数量1，然后在给自己的引用计数➕1.在别的指针来看也看不到他的➕1操作

//        NSArray *arr = @[@10, @35, @47, @11, @5, @57, @39, @14, @27, @26, @84, @75, @63, @41, @37, @24, @96];
    //
        NSArray *arr = @[@1, @2, @3, @4, @5, @6];
    //
//        AVLTree *tree = [AVLTree tree];
    ////
        LinkedList *list = [LinkedList list];
        for (int i = 0; i < arr.count; i++) {
            [list addNode:[arr[i] integerValue] index:i];
//            [tree addNode:[arr[i] integerValue]];
        }
     LinkedNode *node = [list reverseLinkedList1:list.first];
    
    NSLog(@"%ld", (long)node.value);
//        [BinaryTrees println:tree];
    //    lab.text = [BinaryTrees printString:tree];

}

@end
