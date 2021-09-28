

#import "NSString+Trees.h"

@implementation NSString (Trees)

- (NSString *)m_repeat:(NSUInteger)count {
    NSMutableString *string = [NSMutableString string];
    while (count-- > 0) {
        [string appendString:self];
    }
    return string;
}

+ (NSString *)m_blank:(NSUInteger)count {
    return [@" " m_repeat:count];
}

@end
