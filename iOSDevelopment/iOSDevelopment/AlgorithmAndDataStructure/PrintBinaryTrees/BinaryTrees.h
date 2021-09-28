

#import <Foundation/Foundation.h>
#import "BinaryTreeInfo.h"
#import "LevelOrderPrinter.h"
#import "InorderPrinter.h"

typedef NS_ENUM(NSInteger, PrintStyle) {
    PrintStyleLevelOrder,
    PrintStyleInorder
};

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTrees : NSObject
+ (void)println:(id<BinaryTreeInfo>)tree style:(PrintStyle)style;
+ (void)println:(id<BinaryTreeInfo>)tree;

+ (void)print:(id<BinaryTreeInfo>)tree style:(PrintStyle)style;
+ (void)print:(id<BinaryTreeInfo>)tree;

+ (NSString *)printString:(id<BinaryTreeInfo>)tree style:(PrintStyle)style;
+ (NSString *)printString:(id<BinaryTreeInfo>)tree;
@end

NS_ASSUME_NONNULL_END
