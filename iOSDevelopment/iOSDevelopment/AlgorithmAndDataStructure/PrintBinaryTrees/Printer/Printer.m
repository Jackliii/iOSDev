

#import "Printer.h"

@interface Printer()
@end

@implementation Printer

+ (instancetype)printerWithTree:(id<BinaryTreeInfo>)tree {
    Printer *printer = [[self alloc] init];
    printer.tree = tree;
    return printer;
}

- (void)println {
    [self print];
    printf("\n");
}

- (void)print {
    printf("%s", self.printString.UTF8String);
}

- (NSString *)printString {
    return nil;
}

@end
