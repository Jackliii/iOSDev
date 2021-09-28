

#import <Foundation/Foundation.h>
#import "BinaryTreeInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Printer : NSObject
@property (nonatomic, strong) id<BinaryTreeInfo> tree;
+ (instancetype)printerWithTree:(id<BinaryTreeInfo>)tree;
- (void)println;
- (void)print;
- (NSString *)printString;
@end

NS_ASSUME_NONNULL_END
