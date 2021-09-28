

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BinaryTreeInfo <NSObject>
@required
/**
 * who is the root node
 */
- (id)rootNode;
/**
 * how to get the left child of the node
 */
- (id)left:(id)node;
/**
 * how to get the right child of the node
 */
- (id)right:(id)node;
/**
 * how to print the node
 */
- (id)string:(id)node;
@end

NS_ASSUME_NONNULL_END
