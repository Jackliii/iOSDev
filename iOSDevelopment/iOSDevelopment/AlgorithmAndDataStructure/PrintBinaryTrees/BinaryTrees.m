

#import "BinaryTrees.h"

@implementation BinaryTrees

+ (void)println:(id<BinaryTreeInfo>)tree style:(PrintStyle)style {
    [[self _printerWithTree:tree style:style] println];
}

+ (void)println:(id<BinaryTreeInfo>)tree {
    [self println:tree style:PrintStyleLevelOrder];
}

+ (void)print:(id<BinaryTreeInfo>)tree style:(PrintStyle)style {
    [[self _printerWithTree:tree style:style] print];
}

+ (void)print:(id<BinaryTreeInfo>)tree {
    [self print:tree style:PrintStyleLevelOrder];
}

+ (NSString *)printString:(id<BinaryTreeInfo>)tree style:(PrintStyle)style {
    return [self _printerWithTree:tree style:style].printString;
}

+ (NSString *)printString:(id<BinaryTreeInfo>)tree {
    return [self printString:tree style:PrintStyleLevelOrder];
}

+ (Printer *)_printerWithTree:(id<BinaryTreeInfo>)tree style:(PrintStyle)style {
    if (!tree) return nil;
    if (style == PrintStyleLevelOrder) {
        return [LevelOrderPrinter printerWithTree:tree];
    }
    return [InorderPrinter printerWithTree:tree];
}

@end
