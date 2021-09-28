//
//  Node.h
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/11.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, assign) NSInteger value;

+ (instancetype)node;

@end


@interface LinkedNode : Node

@property (nonatomic, strong) LinkedNode *prev;

@property (nonatomic, strong) LinkedNode *next;

+ (instancetype)nodePrev:(LinkedNode *)prev value:(NSInteger)value next:(LinkedNode *)next;

+ (instancetype)nodeValue:(NSInteger)value next:(LinkedNode *)next;

+ (instancetype)nodeValue:(NSInteger)value;

@end


@interface LinkChildNode : LinkedNode

@property (nonatomic, strong) LinkChildNode *child;

@end



@interface TreeNode : Node

@property (nonatomic, weak) TreeNode *parent;

@property (nonatomic, strong) TreeNode *left;

@property (nonatomic, strong) TreeNode *right;

+ (instancetype)nodeWithValue:(NSInteger)value parent:(TreeNode *)parent;

/**
左右子树都为空
 */
- (BOOL)isLeaf;

/**
左右子树都不为空
 */
- (BOOL)hasTwoChildren;

/**
翻转节点
 */
- (TreeNode *)invertTree:(TreeNode *)node;

/**
 自己是父节点的左子树
 */
- (BOOL)isLeftChild;

/**
 自己是父节点的右子树
 */
- (BOOL)isRightChild;

/**
 叔父节点（父节点的兄弟节点）
 */
- (TreeNode *)uncle;

/**祖父节点（父节点的父节点）*/
- (TreeNode *)grand;

/**
 兄弟节点
 */
 - (TreeNode *)sibling;

@end


@interface AVLNode : TreeNode

@property (nonatomic, assign) NSInteger height;

/**
 平衡因子
 */
- (NSInteger)balanceFactor;

/**
 更新左右子树的高度
 */
- (void)updateHeight;

/**
 最高的子树节点
 */
- (AVLNode *)tallerChild;

@end


static BOOL RED = NO;
static BOOL BLACK = YES;

@interface RBNode : TreeNode

@property (nonatomic, assign) BOOL color;

@end


