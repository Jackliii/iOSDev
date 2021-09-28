//
//  Algorithm.m
//  AlgorithmAndDataStructure
//
//  Created by 大明 on 2021/8/27.
//

#import "Algorithm.h"
#import "BSTIterator.h"

@interface Algorithm ()

@end

@implementation Algorithm

NSInteger max = 0;

+ (void)quickSort:(NSArray *)arr {
    NSMutableArray *list = [NSMutableArray arrayWithArray:arr];
    [self quickSort:list start:0 end:arr.count - 1];
    NSLog(@"%@", list);
}

+ (void)quicksort:(NSMutableArray *)arr start:(NSInteger)start end:(NSInteger)end {
    if (end > start) {
        NSInteger pivot = [self partition:arr start:start end:end];
        [self quicksort:arr start:start end:pivot - 1];
        [self quicksort:arr start:pivot + 1 end:end];
    }
}

/**
 函数partition中的变量small相当于指针P1，它始终指向已经发现的最后一个小于中间值的数字。而for循环中的变量i相当于指针P2，它从左到右扫描整个数组。函数partition先将随机选取的中间值交换到数组的尾部，最后又将它交换到合适的位置，使比它小的数字都在它的左边，比它大的数字都在它的右边。函数partition的返回值是中间值的最终下标。
 */
+ (NSInteger)partition:(NSMutableArray *)arr start:(NSInteger)start end:(NSInteger)end {
    NSInteger random = arc4random() % (end - start + 1) + start;
    [self swap:arr index1:random index2:end];
    NSInteger small = start - 1;
    for (NSInteger i = start; i < end; i++) {
        if ([arr[i] integerValue] < [arr[end] integerValue]) {
            small++;
            [self swap:arr index1:i index2:small];
        }
        max++;
    }
    small++;
    [self swap:arr index1:small index2:end];
    return small;
}

+ (void)swap:(NSMutableArray *)arr index1:(NSInteger)index1 index2:(NSInteger)index2 {
    if (index1 != index2 && index2 <arr.count && index1 < arr.count) {
        id temp = arr[index1];
        arr[index1] = arr[index2];
        arr[index2] = temp;
    }
}

//@[@5, @-10, @-2, @2, @6, @9, @4]
//@[@2, @-10, @-2, @5, @6, @9, @4]
+ (void)quickSort:(NSMutableArray *)arr start:(NSInteger)start end:(NSInteger)end {
    if (start < end) {
        NSInteger temp = [arr[end] integerValue];
        NSInteger i = start;
        NSInteger j = end - 1;
        while (i < j) {
            while (i < end && [arr[i] integerValue] <= temp) {
                i++;
            }
            while (i < j && [arr[j] integerValue] > temp) {
                j--;
            }
            if (i < j) {
                id obj = arr[j];
                arr[j] = arr[i];
                arr[i] = obj;
            }
        }
        if ([arr[i] integerValue] > temp) {
            id obj = arr[i];
            arr[i] = @(temp);
            arr[end] = obj;
        }
        [self quickSort:arr start:start end:i - 1];
        [self quickSort:arr start:i + 1 end:end];
    }
}

/**
 题目40：请从一个乱序数组中找出第k大的数字。例如，数组[3，1，2，4，5，5，6]中第3大的数字是5。
 基于最小堆的解法。这种解法每次从数据流中读取一个数字并将其与位于最小堆堆顶的数字进行比较，当新读取的数字大于堆顶的数字时，删除堆顶的数字并将新数字添加到堆中。只要确保最小堆的大小为k，那么位于堆顶的数字就是第k大的数字。从数据流中读取n个数字并找出第k大的数字的时间复杂度是O（nlogk），空间复杂度是O（k）。
 在长度为n的排序数组中，第k大的数字的下标是n-k。下面用快速排序的函数partition对数组分区，如果函数partition选取的中间值在分区之后的下标正好是n-k，分区后左边的值都比中间值小，右边的值都比中间值大，即使整个数组不是排序的，中间值也肯定是第k大的数字。
 如果函数partition选取的中间值在分区之后的下标大于n-k，那么第k大的数字一定位于中间值的左侧，于是再对中间值左侧的子数组分区。类似地，如果函数partition选取的中间值在分区之后的下标小于n-k，那么第k大的数字一定位于中间值的右侧，于是再对中间值右侧的子数组分区。重复这个过程，直到函数partition的返回值正好是下标为n-k的位置。代码中的函数partition就是快速排序的partition函数，此处不再重复它的代码。基于函数partition找出数组中第k大的数字的时间复杂度是O（n），空间复杂度是O（1）。
 由于函数partition随机选择中间值，因此它的返回值也具有随机性，计算这种算法的时间复杂度需要运用概率相关的知识。此处仅计算一种特定场合下的时间复杂度。假设函数partition每次选择的中间值都位于分区后的数组的中间位置，那么第1次函数partition需要扫描长度为n的数组，第2次需要扫描长度为n/2的子数组，第3次需要扫描长度为n/4的数组，重复这个过程，直到子数组的长度为1。由于n+n/2+n/4+…+1=2n，因此总的时间复杂度是O（n）。
 */
+ (NSInteger)findKthLargest:(NSArray *)arr k:(NSInteger)k {
    NSMutableArray *list = [NSMutableArray arrayWithArray:arr];
    NSInteger target = list.count - k;
    NSInteger strat = 0;
    NSInteger end = list.count - 1;
    NSInteger index = [self partition:list start:strat end:end];
    while (index != target) {
        if (index > target) {
            end = index - 1;
        } else {
            strat = index + 1;
        }
        index = [self partition:list start:strat end:end];
    }
    return [list[index] integerValue];
}

/**
    题目1：输入2个int型整数，它们进行除法计算并返回商，要求不得使用乘号'*'、除号'/'及求余符号'%'。当发生溢出时，返回最大的整数值。假设除数不为0。例如，输入15和2，输出15/2的结果，即7。
*/
+ (int)division:(int)v1 v2:(int)v2 {
    if (v2 == 0) {
        //除数不能为0，异常处理
        return 0;
    }
    //0x80000000最小的int整数-2^31  ,0xc0000000是它的一半，即-2^30。
    if (v1 == 0x80000000 && v2 == -1) {
        return INT32_MAX;
    }
    //正数转为负数（因为负数最小为-2^31,正数最大为2^31-1）,为了方便结果是正数还是负数
    //如果负数转为正数可能会发生溢出，所以都转为负数处理。
    int negative = 2;
    if (v1 > 0) {
        negative--;
        v1 = -v1;
    }
    if (v2 > 0) {
        negative--;
        v2 = -v2;
    }
    int resut = [self divideCore:v1 v2:v2];
    //如果为了说明只转了一个数为负数，所以结果要再转回来 -result
    return negative == 1 ? - resut : resut;
}

+ (int)divideCore:(int)v1 v2:(int)v2 {
    int resut = 0;
    while (v1 <= v2) {
        int value = v2;
        int quotient = 1;
        while (value >= 0xc0000000 && v1 <= value + value) {
            quotient += quotient;
            value += value;
        }
        resut += quotient;
        v1 -= value;
    }
    return resut;;
}


/**
 题目2：输入两个表示二进制的字符串，请计算它们的和，并以二进制字符串的形式输出。例如，输入的二进制字符串分别是"11"和"10"，则输出"101"。
 */
+ (NSString *)stringByReversed:(NSString *)str {//反转字符串
    NSMutableString *result = [NSMutableString string];
    for (NSInteger i = str.length; i > 0; i--) {
        [result appendString:[str substringWithRange:NSMakeRange(i-1, 1)]];
    }
    return result;
}

+ (NSString *)addBinary:(NSString *)str1 str2:(NSString *)str2 {
    if (!str1 && !str2) {
        return nil;
    }
    NSMutableString *result = [NSMutableString string];
    NSInteger i = str1.length - 1;
    //用NSInteger就算是负数也不影响不会进循环。如果用NSUInteger如果值小于0那它会被转成很大正数，会超出字符串的范围导致崩溃,而且因为数字太大导致循环一直在进行出不去。⚠️注意负数的二进制表示
    NSInteger j = str2.length - 1;
    int carry = 0;

    while (i >= 0 || j >= 0) {
        int a = i >= 0 ? [str1 characterAtIndex:i--] - '0' : 0;
        int b = j >= 0 ? [str2 characterAtIndex:j--] - '0' : 0;
        int sum = a + b + carry;
        carry = sum >= 2 ? 1 : 0;
        sum = sum >= 2 ? sum - 2 : sum;
        [result appendString:[NSString stringWithFormat:@"%d", sum]];
    }
    if (carry) {
        [result appendString:@"1"];
    }
    return [self stringByReversed:result];
}



/**
 题目3：输入一个非负数n，请计算0到n之间每个数字的二进制形式中1的个数，并输出一个数组。例如，输入的n为4，由于0、1、2、3、4的二进制形式中1的个数分别为0、1、1、2、1，因此输出数组[0，1，1，2，1]。时间复杂度O(n)
 */
+ (NSArray *)countBits:(NSInteger)num {
    if (num < 1) {
        return nil;
    }
    NSMutableArray *result = [NSMutableArray array];
    [result addObject:@(0)];
    for (int i = 1; i <= num; i++) {
        result[i] = @([result[i & (i - 1)] intValue] + 1);
    }
    return result;;
}
/**
 ❖ 根据“i&（i-1）”计算i的二进制形式中1的个数
计算整数i的二进制形式中1的个数有多种不同的方法，其中一种比较高效的方法是每次用“i&（i-1）”将整数i的最右边的1变成0。整数i减去1，那么它最右边的1变成0。如果它的右边还有0，则右边所有的0都变成1，而其左边所有位都保持不变。下面对i和i-1进行位与运算，相当于将其最右边的1变成0。以二进制的1100为例，它减去1的结果是1011。1100和1011的位与运算的结果正好是1000。二进制的1100最右边的1变为0，结果刚好就是1000。
根据前面的分析可知，“i&（i-1）”将i的二进制形式中最右边的1变成0，也就是说，整数i的二进制形式中1的个数比“i&（i-1）”的二进制形式中1的个数多1。
不管整数i的二进制形式中有多少个1，上述代码只根据O（1）的时间就能得出整数i的二进制形式中1的数目，因此时间复杂度是O（n）。
❖ 根据“i/2”计算i的二进制形式中1的个数
还可以使用另一种思路来解决这个问题。如果正整数i是一个偶数，那么i相当于将“i/2”左移一位的结果，因此偶数i和“i/2”的二进制形式中1的个数是相同的。如果i是奇数，那么i相当于将“i/2”左移一位之后再将最右边一位设为1的结果，因此奇数i的二进制形式中1的个数比“i/2”的1的个数多1。例如，整数3的二进制形式是11，有2个1。偶数6的二进制形式是110，有2个1。奇数7的二进制形式是111，有3个1。我们可以根据3的二进制形式中1的个数直接求出6和7的二进制形式中1的个数。用“i>>1”计算“i/2”，用“i&1”计算“i%2”，这是因为位运算比除法运算和求余运算更高效。这个题目是关于位运算的，因此应该尽量运用位运算优化代码，以展示对位运算相关知识的理解。
这种解法的时间复杂度也是O（n）。
 */
+ (NSArray *)countBits1:(NSInteger)num {
    if (num < 1) {
        return nil;
    }
    NSMutableArray *result = [NSMutableArray array];
    [result addObject:@(0)];
    for (int i = 1; i <= num; i++) {
        result[i] = @([result[i >> 1] intValue] + (i & 1));
    }
    return result;;
}


/**
 题目4：输入一个整数数组，数组中只有一个数字出现了一次，而其他数字都出现了3次。请找出那个只出现一次的数字。例如，如果输入的数组为[0，1，0，1，0，1，100]，则只出现一次的数字是100。
*/
+ (NSInteger)singleNumber:(NSArray *)nums {
    if (!nums) {
        return 0;
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (id obj in nums) {
        for (int i = 0; i < 32; i++) {
            arr[i] = @(([obj intValue] >> (31 - 1)) & 1);
        }
    }
    int result = 0;
    for (int i = 0; i < 32; i++) {
        result = (result << 1) + ([arr[i] intValue] % 3);
    }
    return result;
}
/**
 这个题目有一个简化版的类似的题目“输入数组中除一个数字只出现一次之外其他数字都出现两次，请找出只出现一次的数字”。任何一个数字异或它自己的结果都是0。如果将数组中所有数字进行异或运算，那么最终的结果就是那个只出现一次的数字。
 在这个题目中只有一个数字出现了一次，其他数字出现了3次。相同的3个数字异或的结果是数字本身，但是将数组中所有数字进行异或运算并不能消除出现3次的数字。因此，需要想其他办法。
 一个整数是由32个0或1组成的。我们可以将数组中所有数字的同一位置的数位相加。如果将出现3次的数字单独拿出来，那么这些出现了3次的数字的任意第i个数位之和都能被3整除。因此，如果数组中所有数字的第i个数位相加之和能被3整除，那么只出现一次的数字的第i个数位一定是0；如果数组中所有数字的第i个数位相加之和被3除余1，那么只出现一次的数字的第i个数位一定是1。这样只出现一次的任意第i个数位可以由数组中所有数字的第i个数位之和推算出来。当我们知道一个整数任意一位是0还是1之后，就可以知道它的数值。
 int型整数有32位，因此上述代码创建了一个长度为32的数组bitSums，其中“bitSums[i]”用来保存数组nums中所有整数的二进制形式中第i个数位之和。
 代码“（num>>（31-i））&1”用来得到整数num的二进制形式中从左数起第i个数位。整数i先被右移31-i位，原来从左数起第i个数位右移之后位于最右边。接下来与1做位与运算。整数1除了最右边一位是1，其余数位都是0，它与任何一个数字做位与运算的结果都是保留数字的最右边一位，其他数位都被清零。如果整数num从左数起第i个数位是1，那么“（num>>（31-i））&1”的最终结果就是1；否则最终结果为0。
 下面求8位二进制整数01101100从左数起的第2个（从0开始计数）数位。我们先将01101100右移5位（7-2=5）得到00000011，再将它和00000001做位与运算，结果为00000001，即1。8位二进制整数01101100从左边数起的第2个数位的确是1。
 ￼举一反三
 题目：输入一个整数数组，数组中只有一个数字出现m次，其他数字都出现n次。请找出那个唯一出现m次的数字。假设m不能被n整除。
 分析：解决面试题4的方法可以用来解决同类型的问题。如果数组中所有数字的第i个数位相加之和能被n整除，那么出现m次的数字的第i个数位一定是0；否则出现m次的数字的第i个数位一定是1。
 */



/**
 题目5：输入一个递增排序的数组和一个值k，请问如何在数组中找出两个和为k的数字并返回它们的下标？假设数组中存在且只存在一对符合条件的数字，同时一个数字不能使用两次。例如，输入数组[1，2，4，6，10]，k的值为8，数组中的数字2与6的和为8，它们的下标分别为1与3。
 */
+ (NSArray *)twoSum:(NSArray *)arr add:(NSInteger)target {
    if (arr.count < 2) return nil;
    NSInteger index1 = 0;
    NSInteger index2 = arr.count - 1;
    while (YES) {
        if (index1 == index2) {
            return nil;
        }
        NSInteger num = [arr[index1] integerValue] + [arr[index2] integerValue];
        if (num > target) {
            index2--;
        } else if (num < target) {
            index1++;
        } else {
            NSLog(@"下标%ld、%ld的元素和为%ld", (long)index1, (long)index2, (long)target);
            return @[@(index1), @(index2)];
        }
    }
}

/**
 题目6：输入一个数组，如何找出数组中所有和为0的3个数字的三元组？需要注意的是，返回值中不得包含重复的三元组。例如，在数组[-1，0，1，2，-1，-4]中有两个三元组的和为0，它们分别是[-1，0，1]和[-1，-1，2]。
 */
+ (NSArray *)threeSum:(NSArray *)arr {
    NSMutableArray *list = [NSMutableArray array];
    if (arr.count > 2) {
        arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj2 integerValue] < [obj1 integerValue];
        }];
        int i = 0;
        while (i < arr.count - 2) {
            NSArray *objs = [self twoSum:arr i:i];
            if (objs) {
                [list addObjectsFromArray:objs];
            }
            int temp = [arr[i] intValue];
            while (i < arr.count && [arr[i] intValue] == temp) {
                ++i;
            }
        }
    }
    NSLog(@"%@", list);
    return list;
}

+ (NSArray *)twoSum:(NSArray *)arr i:(NSUInteger)i {
    if (arr.count < 1) return nil;
    NSMutableArray *list = [NSMutableArray array];
    NSUInteger j = i + 1;
    NSUInteger k = arr.count - 1;
    while (j < k) {
        NSInteger num = [arr[j] integerValue] + [arr[k] integerValue] + [arr[i] integerValue];
        if (num == 0) {
            [list addObject:[NSArray arrayWithObjects:arr[i], arr[j], arr[k], nil]];
            NSInteger temp = [arr[j] integerValue];
            while ([arr[j] integerValue] == temp && j < k) {
                ++j;
            }
        } else if (num < 0) {
            ++j;
        } else {
            --k;
        }
    }
    return list;
}

/**
 题目7：输入一个正整数组成的数组和一个正整数k，请问数组中和大于或等于k的连续子数组的最短长度是多少？如果不存在所有数字之和大于或等于k的子数组，则返回0。例如，输入数组[5，1，4，3]，k的值为7，和大于或等于7的最短连续子数组是[4，3]，因此输出它的长度2。
 */
+ (int)minSubArray:(NSArray *)arr k:(NSInteger)k {
    int left = 0;
    int sum = 0;
    int minLength = INT32_MAX;
    for (int right = 0; right < arr.count; right++) {
        sum += [arr[right] intValue];
        while (left <= right && sum >= k) {
            minLength = MIN(minLength, right - left + 1);
            sum -= [arr[left++] intValue];
        }
    }
    minLength = minLength == INT32_MAX ? 0 : minLength;
    NSLog(@"%d", minLength);
    return minLength;
}
/**
 ⚠️使用双指针解决子数组之和的面试题有一个前提条件——数组中的所有数字都是正数。
 子数组由数组中一个或连续的多个数字组成。一个子数组可以用两个指针表示。如果第1个指针P1指向子数组的第1个数字，第2个指针P2指向子数组的最后一个数字，那么子数组就是由这两个指针之间的所有数字组成的。
 指针P1和P2初始化的时候都指向数组的第1个元素。如果两个指针之间的子数组中所有数字之和大于或等于k，那么把指针P1向右移动。每向右移动指针P1一步，相当于从子数组的最左边删除一个数字，子数组的长度也减1。由于数组中的数字都是正整数，从子数组中删除一些数字就能减小子数组之和。由于目标是找出和大于或等于k的最短子数组，因此一直向右移动指针P1，直到子数组的和小于k为止。
 如果两个指针之间的子数组中所有数字之和小于k，那么把指针P2向右移动。指针P2每向右移动一步就相当于在子数组的最右边添加一个新的数字，子数组的长度加1。由于数组中的所有数字都是正整数，因此在子数组中添加新的数字能得到更大的子数组之和。
 */

/**
 题目8：输入一个由正整数组成的数组和一个正整数k，请问数组中有多少个数字乘积小于k的连续子数组？例如，输入数组[10，5，2，6]，k的值为100，有8个子数组的所有数字的乘积小于100，它们分别是[10]、[5]、[2]、[6]、[10，5]、[5，2]、[2，6]和[5，2，6]。
 */
+ (int)numSubArrayProductLessThanK:(NSArray *)arr k:(NSInteger)k {
    long product = 1;
    int left = 0;
    int count = 0;
    for (int right = 0; right < arr.count; right++) {
        product *= [arr[right] intValue];
        while (left <= right && product >= k) {
            product /= [arr[left++] intValue];
        }
        count += right >= left ? right - left + 1 : 0;
    }
    NSLog(@"%d", count);
    return count;
}


/**
 题目9：输入一个整数数组和一个整数k，请问数组中有多少个数字之和等于k的连续子数组？例如，输入数组[1，1，1]，k的值为2，有2个连续子数组之和等于2。
 */
+ (int)subArraySum:(NSArray *)arr k:(int)k {
    if (!arr) {
        return 0;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@(1) forKey:@"0"];
    
    int sum = 0;
    int count = 0;
    for (int i = 0; i < arr.count; i++) {
        sum += [arr[i] intValue];
        count += [self getOrDefault:dict key:[NSString stringWithFormat:@"%d", sum - k] value:0];
        int tmp = [self getOrDefault:dict key:[NSString stringWithFormat:@"%d", sum] value:0] + 1;
        [dict setValue:[NSString stringWithFormat:@"%d", tmp] forKey:[NSString stringWithFormat:@"%d", sum]];
    }
    NSLog(@"%d", count);
    return count;
}

+ (int)getOrDefault:(NSDictionary *)dict key:(NSString *)key value:(int)value {
   BOOL c = [[dict allKeys] containsObject:key];
    if (c) {
        return [dict[key] intValue];
    }
    return value;
}

/**
 题目10：输入一个只包含0和1的数组，请问如何求0和1的个数相同的最长连续子数组的长度？例如，在数组[0，1，0]中有两个子数组包含相同个数的0和1，分别是[0，1]和[1，0]，它们的长度都是2，因此输出2。
 首先把输入数组中所有的0都替换成-1，那么题目就变成求包含相同数目的-1和1的最长子数组的长度。在一个只包含数字1和-1的数组中，如果子数组中-1和1的数目相同，那么子数组的所有数字之和就是0，因此这个题目就变成求数字之和为0的最长子数组的长度。
 如果数组中前i个数字之和为m，前j个数字（j>i）之和也为m，那么从第i+1个数字到第j个数字的子数组的数字之和为0，这个和为0的子数组的长度是j-i。
 如果扫描到数组的第j个数字并累加得到前j个数字之和m，那么就需要知道是否存在一个i（i＜j）使数组中前i个数字之和也为m。可以把数组从第1个数字开始到当前扫描的数字累加之和保存到一个哈希表中。由于我们的目标是求出数字之和为0的最长子数组的长度，因此还需要知道第1次出现累加之和为m时扫描到的数字的下标。因此，哈希表的键是从第1个数字开始累加到当前扫描到的数字之和，而值是当前扫描的数字的下标。
 */
+ (int)findMaxLength:(NSArray *)arr {
    if (!arr) {
        return 0;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@(-1) forKey:@"0"];
    int sum = 0;
    int max = 0;
    for (int i = 0; i < arr.count; i++) {
        sum += [arr[i] intValue] == 0 ? -1 : 1;
        if ([[dict allKeys] containsObject:@(sum)]) {
            NSString *key = [NSString stringWithFormat:@"%d", sum];
            int c = [[dict valueForKey:key] intValue];
            max = MAX(max, i - c);
        } else {
            [dict setValue:@(i) forKey:[NSString stringWithFormat:@"%d", sum]];
        }
    }
    return max;
}


/**
 题目11：输入一个整数数组，如果一个数字左边的子数组的数字之和等于右边的子数组的数字之和，那么返回该数字的下标。如果存在多个这样的数字，则返回最左边一个数字的下标。如果不存在这样的数字，则返回-1。例如，在数组[1，7，3，6，2，9]中，下标为3的数字（值为6）的左边3个数字1、7、3的和与右边两个数字2和9的和相等，都是11，因此正确的输出值是3。
 */
+ (int)pivotIndex:(NSArray *)arr {
    int total = 0;
    for (id obj in arr) {
        total += [obj intValue];
    }
    int sum = 0;
    for (int i = 0; i < arr.count; i++) {
        sum += [arr[i] intValue];
        if (sum - [arr[i] intValue] == total - sum) {
            return i;
        }
    }
    return -1;
}

/**
 题目12：输入字符串s1和s2，如何判断字符串s2中是否包含字符串s1的某个变位词？如果字符串s2中包含字符串s1的某个变位词，则字符串s1至少有一个变位词是字符串s2的子字符串。假设两个字符串中只包含英文小写字母。例如，字符串s1为"ac"，字符串s2为"dgcaf"，由于字符串s2中包含字符串s1的变位词"ca"，因此输出为true。如果字符串s1为"ab"，字符串s2为"dgcaf"，则输出为false。
 变位词是与字符串相关的面试题中经常出现的一个概念。所谓的变位词是指组成各个单词的字母及每个字母出现的次数完全相同，只是字母排列的顺序不同。例如，"pots"、"stop"和"tops"就是一组变位词。
 */
+ (BOOL)checkInclusion:(NSString *)str1 str2:(NSString *)str2 {
    if (str2.length < str1.length) {
        return false;
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 26; i++) {
        [arr addObject:@(0)];
    }
    for (int i = 0; i < str1.length; i++) {//对str1和str2进行加减操作，所以后面会有一次（第一次对比）判断是否为YES
        int index = [str1 characterAtIndex:i] - 'a';
        int v = [arr[index] intValue] + 1;
        arr[index] = @(v);
        
        int index1 = [str2 characterAtIndex:i] - 'a';
        int v1 = [arr[index1] intValue] - 1;
        arr[index1] = @(v1);
    }
    if ([self areAllZero:arr]) {
        return YES;
    }
    NSLog(@"%@", arr);
    for (NSUInteger i = str1.length; i < str2.length; i++) {
        //第一次进来就相当于向右移动了，所以进行相关操作
        //每删除一个+1。
        int index1 = [str2 characterAtIndex:i - str1.length] - 'a';
        int v1 = [arr[index1] intValue] + 1;
        arr[index1] = @(v1);

        //每右移也就是增加一个，-1
        int index = [str2 characterAtIndex:i] - 'a';
        int v = [arr[index] intValue] - 1;
        arr[index] = @(v);
        
        NSLog(@"%@", arr);

        if ([self areAllZero:arr]) {
            return YES;
        }
    }
    return false;
}

+ (BOOL)areAllZero:(NSArray *)arr {
    for (id obj in arr) {
        if ([obj intValue] != 0) {
            return NO;
        }
    }
    return YES;
}


/**
 题目13：输入字符串s1和s2，如何找出字符串s1的所有变位词在字符串s2中的起始下标？假设两个字符串中只包含英文小写字母。例如，字符串s2为"cbadabacg"，字符串s1为"abc"，字符串s1的两个变位词"cba"和"bac"是字符串s2中的子字符串，输出它们在字符串s2中的起始下标0和5。
 */
+ (NSArray *)findAnagrams:(NSString *)str1 str2:(NSString *)str2 {
    if (str2.length < str1.length) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 26; i++) {
        [arr addObject:@(0)];
    }
    for (int i = 0; i < str1.length; i++) {//对str1和str2进行加减操作，所以后面会有一次（第一次对比）判断是否为YES
        int index = [str1 characterAtIndex:i] - 'a';
        int v = [arr[index] intValue] + 1;
        arr[index] = @(v);
        
        int index1 = [str2 characterAtIndex:i] - 'a';
        int v1 = [arr[index1] intValue] - 1;
        arr[index1] = @(v1);
    }
    NSMutableArray *list = [NSMutableArray array];
    if ([self areAllZero:arr]) {
        [list addObject:@(0)];
    }
//    NSLog(@"%@", arr);
    for (NSUInteger i = str1.length; i < str2.length; i++) {
        //第一次进来就相当于向右移动了，所以进行相关操作
        //每删除一个+1。
        int index1 = [str2 characterAtIndex:i - str1.length] - 'a';
        int v1 = [arr[index1] intValue] + 1;
        arr[index1] = @(v1);

        //每右移也就是增加一个，-1
        int index = [str2 characterAtIndex:i] - 'a';
        int v = [arr[index] intValue] - 1;
        arr[index] = @(v);
        
//        NSLog(@"%@", arr);
        if ([self areAllZero:arr]) {
             [list addObject:@(i - str1.length + 1)];
        }
    }
    return list;
}


/**
 题目14：输入一个字符串，求该字符串中不含重复字符的最长子字符串的长度。例如，输入字符串"babcca"，其最长的不含重复字符的子字符串是"abc"，长度为3。
 */
+ (int)lengthOfLongestSubstring:(NSString *)str {
    if (str.length < 1) {
        return 0;
    }
    int l = 0;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    int first = 0;
    int second = 0;
    for (int i = 0; i < str.length; i++) {
        NSString *s = [str substringWithRange:NSMakeRange(second, 1)];
        while ([[dict allKeys] containsObject:s]) {
            if (i == str.length - 1) {//如果是最后一个重复，那就不用走这个流程了，结果已经出来了
                return l;
            }
            NSString *key = [str substringWithRange:NSMakeRange(first, 1)];
            [dict removeObjectForKey:key];
            first ++;
        }
        second++;
        [dict setValue:@(0) forKey:s];
        l = MAX(l, second - first);
    }
    //@"babccabcdefg"
    return l;
}


/**
 题目15：给定一个字符串，请判断它是不是回文。假设只需要考虑字母和数字字符，并忽略大小写。例如，"Was it a cat I saw？"是一个回文字符串，而"race a car"不是回文字符串。
 */
+ (BOOL)isPalindrome:(NSString *)str {
    if (str.length < 1) {
        return 0;
    }
    int i = 0;
    NSInteger j = str.length - 1;
    NSString *s = [str lowercaseString];
    while (i < j) {
        NSString *a = [s substringWithRange:NSMakeRange(i, 1)];
        NSString *b = [s substringWithRange:NSMakeRange(j, 1)];
        if ([a isEqualToString:b]) {
            i++;
            j--;
        } else {
            //也许有一些特殊情况要处理
            return false;
        }
    }
    return YES;
}


/**
 题目16：给定一个字符串，请判断如果最多从字符串中删除一个字符能不能得到一个回文字符串。例如，如果输入字符串"abca"，由于删除字符'b'或'c'就能得到一个回文字符串，因此输出为true。
 */
+ (BOOL)vaildPalindrome:(NSString *)str {
    if (str.length < 1) {
        return 0;
    }
    int start = 0;
    NSInteger end = str.length - 1;
    for (int i = 0; i < str.length; i++) {
        if ([str characterAtIndex:start] != [str characterAtIndex:end]) {
            break;
        }
        start++;
        end--;
    }
    return start == str.length / 2 || [self palindrome:str start:start end:end - 1] || [self palindrome:str start:start + 1 end:end];
}

+ (BOOL)palindrome:(NSString *)str start:(int)start end:(NSInteger)end {
    while (start < end) {
        if ([str characterAtIndex:start] != [str characterAtIndex:end]) {
            break;
        }
        start++;
        end--;
    }
    return start >= end;
}


/**
 题目17：给定一个字符串，请问该字符串中有多少个回文连续子字符串？例如，字符串"abc"有3个回文子字符串，分别为"a"、"b"和"c"；而字符串"aaa"有6个回文子字符串，分别为"a"、"a"、"a"、"aa"、"aa"和"aaa"。
 */
+ (int)subPalindromeStringCount:(NSString *)str {
    if (str.length < 1) {
        return 0;
    }
    int count = 0;
    for (int i = 0; i < str.length; i++) {
        count += [self countPalindrome:str start:i end:i];//奇数字符串
        count += [self countPalindrome:str start:i end:i + 1];//偶数字符串
    }
    return count;
}

+ (int)countPalindrome:(NSString *)str start:(int)start end:(NSInteger)end {
    int count = 0;
    while (start >=0 && end < str.length && ([str characterAtIndex:start] == [str characterAtIndex:end])) {
        count++;
        start--;
        end++;
    }
    return count;
}


/**
 题目18：如果给定一个链表，请问如何删除链表中的倒数第k个节点？假设链表中节点的总数为n，那么1≤k≤n。要求只能遍历链表一次。
 利用前后双指针解决，即一个指针在链表中提前朝着指向下一个节点的指针移动若干步，然后移动第2个指针。前后双指针的经典应用是查找链表的倒数第k个节点。先让第1个指针从链表的头节点开始朝着指向下一个节点的指针先移动k-1步，然后让第2个指针指向链表的头节点，再让两个指针以相同的速度一起移动，当第1个指针到达链表的尾节点时第2个指针正好指向倒数第k个节点。
 前后双指针，即一个指针在链表中提前朝着指向下一个节点的指针移动若干步，然后移动第2个指针。前后双指针的经典应用是查找链表的倒数第k个节点。先让第1个指针从链表的头节点开始朝着指向下一个节点的指针先移动k-1步，然后让第2个指针指向链表的头节点，再让两个指针以相同的速度一起移动，当第1个指针到达链表的尾节点时第2个指针正好指向倒数第k个节点。
 */
+ (LinkedNode *)removeNthFromeEnd:(LinkedNode *)head n:(int)n {
  //1->4->5->9->2->7->14,->18->13
    LinkedNode *dummy = [LinkedNode nodeValue:0 next:head];//利用虚拟头节点简化代码逻辑
    LinkedNode *first = head;
    for (int i = 0; i < n; i++) {
        first = first.next;
    }
    LinkedNode *second = dummy;//假如要删除14，就要找到他的前一个节点（也就是7），所以他走的要比原来解决思路要慢一步
    while (first != nil) {
        first = first.next;
        second = second.next;
    }
    second.next = second.next.next;
    return dummy.next;
}

+ (LinkedNode *)getNodeInLoop:(LinkedNode *)head {
    if (head == nil || head.next == nil) {
        return nil;
    }
    LinkedNode *slow = head.next;
    LinkedNode *fast = slow.next;
    
    while (fast != nil && fast.next != nil) {
        if (slow == fast) {
            return slow;
        }
        slow = slow.next;
        fast = fast.next.next;
    }
    return nil;
}

/**
 题目19：如果一个链表中包含环，那么应该如何找出环的入口节点？从链表的头节点开始顺着next指针方向进入环的第1个节点为环的入口节点。
 */
+ (LinkedNode *)detectCycle:(LinkedNode *)head {
    LinkedNode *node = [self getNodeInLoop:head];
    if (node == nil) {
        return nil;
    }
    LinkedNode *second = head;
    while (second != node) {
        second = second.next;
        node = node.next;
    }
    return node;
}

/**
 题目20：输入两个单向链表，请问如何找出它们的第1个重合节点.
 首先遍历两个链表得到它们的长度，这样就能知道哪个链表比较长，以及长的链表比短的链表多几个节点。在第2次遍历时，第1个指针P1在较长的链表中先移动若干步，再把第2个指针P2初始化到较短的链表的头节点，然后这两个指针按照相同的速度在链表中移动，直到它们相遇。两个指针相遇的节点就是两个链表的第1个公共节点。
 */
+ (LinkedNode *)getIntersectionNode:(LinkedNode *)headA headB:(LinkedNode *)headB {
    int a = [self listCount:headA];
    int b = [self listCount:headA];
    int delta = abs(a - b);
    
    LinkedNode *longer = headA;
    LinkedNode *shorter = headB;
    if (a < b) {
        shorter = headA;
        longer = headB;
    }
    for (int i = 0; i < delta; i++) {
        longer = longer.next;
    }
    while (longer != shorter) {
        shorter = shorter.next;
        longer = longer.next;
    }
    return longer;
}

+ (int)listCount:(LinkedNode *)head {
    int count = 0;
    while (head != nil) {
        head = head.next;
        count++;
    }
    return count;
}

/**
 题目21：给定两个表示非负整数的单向链表，请问如何实现这两个整数的相加并且把它们的和仍然用单向链表表示？链表中的每个节点表示整数十进制的一位，并且头节点对应整数的最高位数而尾节点对应整数的个位数.
 解决这个问题的办法是把表示整数的链表反转。反转之后的链表的头节点表示个位数，尾节点表示最高位数。此时从两个链表的头节点开始相加，就相当于从整数的个位数开始相加。
 在做加法时还需要注意的是进位。如果两个整数的个位数相加的和超过10，就会往十位数产生一个进位。在下一步做十位数相加时就要把这个进位考虑进去。
 */
+ (LinkedNode *)addTwoNumbers:(LinkedNode *)head1 head2:(LinkedNode *)head2 {
    LinkedNode *node1 = [self reverseLinkedList:head1];
    LinkedNode *node2 = [self reverseLinkedList:head2];
    LinkedNode *node = [self addNodeNumber:node1 head2:node2];
    return [self reverseLinkedList:node];
}

+ (LinkedNode *)addNodeNumber:(LinkedNode *)head1 head2:(LinkedNode *)head2 {
    LinkedNode *dummy = [LinkedNode node];
    LinkedNode *subNode = dummy;
    LinkedNode *node1 = head1;
    LinkedNode *node2 = head2;
    BOOL isAdd = NO;
    NSInteger value = 0;
    while (node1 != nil && node2 != nil) {
        value = node1.value + node2.value + isAdd;
        isAdd = NO;
        if (value > 9) {
            isAdd = YES;
            value -= 10;
        }
        subNode.next = [LinkedNode nodeValue:value];
        subNode = subNode.next;
        node1 = node1.next;
        node2 = node2.next;
    }
    LinkedNode *node = node1 == nil ? node2 : node1;
    while (node) {
        value = node.value;
        if (isAdd) {
            value++;
            isAdd = false;
        }
        if (value > 9) {
            isAdd = YES;
            value -= 10;
        }
        subNode.next = [LinkedNode nodeValue:value];
        subNode = subNode.next;
        node = node.next;
    }
    if (isAdd) {
        subNode.next = [LinkedNode nodeValue:1];
        subNode = subNode.next;
    }
    return dummy.next;
}

/**
 反转链表
 */
+ (LinkedNode *)reverseLinkedList:(LinkedNode *)head {
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


/**
 题目22：给定一个链表，链表中节点的顺序是L0→L1→L2→…→Ln-1→Ln，请问如何重排链表使节点的顺序变成L0→Ln→L1→Ln-1→L2→Ln-2→…？
 */
+ (void)reorderList:(LinkedNode *)head {
    if (head == nil || head.next == nil) {
        return;
    }
    LinkedNode *dummy = [LinkedNode nodeValue:0 next:head];//添加一个虚拟头节点用于简化处理链表节点数量奇数偶数问题，因为需要把后半段的头节点找出来进行反转
    
    LinkedNode *fast = dummy;
    LinkedNode *slow = dummy;
    while (fast != nil && fast.next != nil) {
        fast = fast.next.next;
        slow = slow.next;
    }
    LinkedNode *temp = slow.next;
    slow.next = nil;
    
    LinkedNode *secondHead = [self reverseLinkedList:temp];
    LinkedNode *prev = dummy;
    while (head != nil && secondHead != nil) {
        LinkedNode *node = head.next;
        prev.next = head;
        head.next = secondHead;
        prev = secondHead;
        head = node;
        secondHead = secondHead.next;
    }
    if (head != nil) {
        prev.next = head;
    }
    NSMutableString *str = [NSMutableString string];
    while (dummy.next != nil) {
        dummy = dummy.next;
        [str appendString:[NSString stringWithFormat:@"%ld->",(long)dummy.value]];
    }
    NSLog(@"%@", str);
}


/**
 题目23：如何判断一个链表是不是回文？要求解法的时间复杂度是O（n），并且不得使用超过O（1）的辅助空间。如果一个链表是回文，那么链表的节点序列从前往后看和从后往前看是相同的
 */
+ (BOOL)linkIsPalindrome:(LinkedNode *)head {
    if (head == nil || head.next == nil) {
        return YES;
    }
    LinkedNode *fast = head.next;
    LinkedNode *slow = head;
    while (fast.next != nil && fast.next.next != nil) {
        fast = fast.next.next;
        slow = slow.next;
    }
    LinkedNode *node = slow.next;
    if (fast.next != nil) {
        node = slow.next.next;
    }
    slow.next = nil;
    node = [self reverseLinkedList:node];
    while (head != nil && node != nil) {
        if (head.value != node.value) {
            return NO;
        }
        head = head.next;
        node = node.next;
    }
    return head == nil && node == nil;
}

/**
 题目24：在一个多级双向链表中，节点除了有两个指针分别指向前后两个节点，还有一个指针指向它的子链表，并且子链表也是一个双向链表，它的节点也有指向子链表的指针。请将这样的多级双向链表展平成普通的双向链表，即所有节点都没有子链表。
 1= 2 = 3 = 4
   ｜
   5  =  6 = 7
      ｜
      8 = 9
 结果为1 =2 = 5 = 6 = 8  = 9 = 7 = 3 = 4
 */
+ (LinkChildNode *)flatten:(LinkChildNode *)head {
    [self flattenGetTail:head];
    return head;
}

+ (LinkChildNode *)flattenGetTail:(LinkChildNode *)head {
    LinkChildNode *node = head;
    LinkChildNode *tail = nil;
    while (node != nil) {
        LinkChildNode *next = (LinkChildNode *)node.next;
        if (node.child != nil) {
            LinkChildNode *child = node.child;
            LinkChildNode *childTail = [self flattenGetTail:node.child];
            node.child = nil;
            node.next = child;
            child.prev = node;
            childTail.next = next;
            if (next != nil) {
                next.prev = childTail;
            }
            tail = childTail;
        } else {
            tail = node;
        }
        node = next;
    }
    return tail;
}

/**
 题目25：在一个循环链表中节点的值递增排序，请设计一个算法在该循环链表中插入节点，并保证插入节点之后的循环链表仍然是排序的。
 */
+ (LinkedNode *)inset:(LinkedNode *)head value:(int)value {
    LinkedNode *node = [LinkedNode nodeValue:value];
    if (head == nil) {
        head = node;
        head.next = head;
    } else if (head.next == head) {
        head.next = node;
        node.next = head;
    } else {
        [self insertCore:head node:node];
    }
    return head;
}

+ (void)insertCore:(LinkedNode *)head node:(LinkedNode *)node {
    LinkedNode *cur = head;
    LinkedNode *next = head.next;
    LinkedNode *biggest = head;
//    while (!(cur.value <= node.value && next.value >= node.value) && next != head) {
//        cur = next;
//        next = next.next;
//        if (cur.value >= biggest.value) {
//            biggest = cur;
//        }
//        a++;
//    }
//    if (cur.value <= node.value && next.value >= node.value) {
//        cur.next = node;
//        node.next = next;
//    } else {
//        node.next = biggest.next;
//        biggest.next = node;
//    }
    
    do {
        if (cur.value <= node.value && next.value >= node.value) {
            cur.next = node;
            node.next = next;
            return;
        }
        if (next.value >= biggest.value) {
            biggest = next;
        }
        cur = next;
        next = next.next;
    } while (cur != head);
    node.next = biggest.next;
    biggest.next = node;
}


/**
 题目26：请设计一个算法将二叉树序列化成一个字符串，并能将该字符串反序列化出原来二叉树的算法。
 先考虑如何将二叉树序列化为一个字符串。需要逐个遍历二叉树的每个节点，每遍历到一个节点就将节点的值序列化到字符串中。以前序遍历的顺序遍历二叉树最适合序列化。如果采用前序遍历的顺序，那么二叉树的根节点最先序列化到字符串中，然后是左子树，最后是右子树。这样做的好处是在反序列化时最方便，从字符串中读出的第1个数值一定是根节点的值。
 实际上，只把节点的值序列化到字符串中是不够的。首先，要用一个分隔符（如逗号）把不同的节点分隔开。其次，还要考虑如何才能在反序列化的时候构建不同结构的二叉树。用#代表节点不存在，或者子节点不存在
 */
+ (NSString *)serializeForPreorderTraversal:(TreeNode *)node {
    if (node == nil) return @"#";
    NSString *leftStr = [self serializeForPreorderTraversal:node.left];
    NSString *rightStr = [self serializeForPreorderTraversal:node.right];
    return [NSString stringWithFormat:@"%ld,%@,%@", (long)node.value, leftStr, rightStr];
}

int a = 0;

/**
 反序列化二叉树
 由于把二叉树序列化成一个以逗号作为分隔符的字符串，因此可以根据分隔符把字符串分隔成若干子字符串，每个子字符串对应二叉树的一个节点。如果一个节点为null，那么它和"＃"对应；否则这个节点将和一个表示它的值的子字符串对应。
 如果用前序遍历序列化二叉树，那么分隔后的第1个字符串对应的就是二叉树的根节点，因此可以先根据这个字符串构建出二叉树的根节点。然后先后反序列化二叉树的左子树和右子树。在反序列化它的左子树和右子树时可以采用类似的方法，也就是说，可以调用递归函数解决反序列化子树的问题。
 */
+ (TreeNode *)deserializeForPreorderTraversalString:(NSString *)str {
    NSArray *strings = [str componentsSeparatedByString:@","];
    return [self dfs:strings i:a];
}

+ (TreeNode *)dfs:(NSArray *)strings i:(int)i {
    NSString *str = strings[a];
    a++;
    if ([str isEqualToString:@"#"]) {
        return nil;
    }
    TreeNode *node = [TreeNode node];
    node.value = [str integerValue];
    node.left = [self dfs:strings i:a];
    node.right = [self dfs:strings i:a];
    return node;
}

/**
 题目27：在一棵二叉树中所有节点都在0～9的范围之内，从根节点到叶节点的路径表示一个数字。求二叉树中所有路径表示的数字之和。
         3
       /        \
      9           0
    /       \           \
   5         1           2
 二叉树有3条从根节点到叶节点的路径，它们分别表示数字395、391和302，这3个数字之和是1088。首先考虑如何计算路径表示的数字。顺着指向子节点的指针路径向下遍历二叉树，每到达一个节点，相当于在路径表示的数字末尾添加一位数字。例如，在最开始到达根节点时，它表示数字3。然后到达节点9，此时路径表示数字39（3×10+9=39）。然后向下到达节点5，此时路径表示数字395（39×10+5=395）。
 这就是说，每当遍历到一个节点时都计算从根节点到当前节点的路径表示的数字。如果这个节点还有子节点，就把这个值传下去继续遍历它的子节点。先计算到当前节点为止的路径表示的数字，再计算到它的子节点的路径表示的数字，这实质上就是典型的二叉树前序遍历。
 */
+ (NSInteger)binaryTreeNodesSum:(TreeNode *)root {
    return [self nodeSum:root path:0];
}

+ (NSInteger)nodeSum:(TreeNode *)node path:(NSInteger)path {
    if (node == nil) {
        return 0;
    }
    path = path * 10 + node.value;
    if ([node isLeaf]) {
        return path;
    }
    return [self nodeSum:node.left path:path] + [self nodeSum:node.right path:path];
}


/**
 题目28：给定一棵二叉树和一个值sum，求二叉树中节点值之和等于sum的路径的数目。路径的定义为二叉树中顺着指向子节点的指针向下移动所经过的节点，但不一定从根节点开始，也不一定到叶节点结束。例如，在二叉树中有两条路径的节点值之和等于8，其中，第1条路径从节点5开始经过节点2到达节点1，第2条路径从节点2开始到节点6。
        5
     /           \
    2               4
  /       \        /        \
 1         6     3          7
 */
+ (NSInteger)pathSum:(TreeNode *)root sum:(NSInteger)sum {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[self str:1] forKey:[self str:0]];
    return [self pathDfs:root sum:sum dict:dict path:0];
}

+ (NSString *)str:(NSInteger)value {
    return [NSString stringWithFormat:@"%ld", value];
}

+ (NSInteger)pathDfs:(TreeNode *)node sum:(NSInteger)sum dict:(NSMutableDictionary *)dict path:(NSInteger)path {
    if (node == nil) {
        return 0;
    }
    path += node.value;
    int count = [self getOrDefault:dict key:[self str:path - sum] value:0];
    int v = [self getOrDefault:dict key:[self str:path] value:0] + 1;
    [dict setObject:[self str:v] forKey:[self str:path]];
    count += [self pathDfs:node.left sum:sum dict:dict path:path];
    count += [self pathDfs:node.right sum:sum dict:dict path:path];
    NSInteger n = [[dict objectForKey:[self str:path]] integerValue] - 1;
    [dict setObject:[self str:n] forKey:[self str:path]];
    return count;
}


/**
 题目29：在二叉树中将路径定义为顺着节点之间的连接从任意一个节点开始到达任意一个节点所经过的所有节点。路径中至少包含一个节点，不一定经过二叉树的根节点，也不一定经过叶节点。给定非空的一棵二叉树，请求出二叉树所有路径上节点值之和的最大值。例如，二叉树中，从节点15开始经过节点20到达节点7的路径的节点值之和为42，是节点值之和最大的路径。
     -9
    /      \
   4        20
      /       \
    15          7
   /
 -3
 值得注意的是，如果一条路径同时经过某个节点的左右子节点，那么该路径一定不能经过它的父节点。例如，经过节点20、节点15、节点7的路径不能经过节点-9。
 也就是说，当路径到达某个节点时，该路径既可以前往它的左子树，也可以前往它的右子树。但如果路径同时经过它的左右子树，那么就不能经过它的父节点。
 由于路径可能只经过左子树或右子树而不经过根节点，为了求得二叉树的路径上节点值之和的最大值，需要先求出左右子树中路径节点值之和的最大值（左右子树中的路径不经过当前节点），再求出经过根节点的路径节点值之和的最大值，最后对三者进行比较得到最大值。由于需要先求出左右子树的路径节点值之和的最大值，再求根节点，这看起来就是后序遍历。基于二叉树的后序遍历。代码按照后序遍历的顺序遍历二叉树的每个节点。由于求左右子树的路径节点值之和的最大值与求整棵二叉树的路径节点值之和的最大值是同一个问题，因此用递归的代码解决这个问题最直观。
 代码中的参数maxSum是路径节点值之和的最大值。由于递归函数maxDfs需要把这个最大值传给它的调用者，因此参数maxSum被定义为长度为1的数组。先递归调用函数maxDfs求得左右子树的路径节点值之和的最大值maxSumLeft及maxSumRight，再求出经过当前节点root的路径的节点值之和的最大值，那么参数maxSum就是这3个值的最大值。
函数的返回值是经过当前节点root并前往其左子树或右子树的路径的节点值之和的最大值。它的父节点要根据这个返回值求路径的节点值之和。由于同时经过左右子树的路径不能经过父节点，因此返回值是变量left与right的较大值加上当前节点root的值。
 */
+ (NSInteger)nodeMaxSum:(TreeNode *)node {
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@(INT32_MIN)];
    [self maxDfs:node maxSum:arr];
    return [arr[0] integerValue];
}

+ (NSInteger)maxDfs:(TreeNode *)node maxSum:(NSMutableArray *)maxSum {
    if (node == nil) {
        return 0;
    }
    NSMutableArray *maxSumLeft = [NSMutableArray array];
    [maxSumLeft addObject:@(INT32_MIN)];
    NSInteger left = MAX(0, [self maxDfs:node.left maxSum:maxSumLeft]);
    
    NSMutableArray *maxSumRight = [NSMutableArray array];
    [maxSumRight addObject:@(INT32_MIN)];
    NSInteger right = MAX(0, [self maxDfs:node.right maxSum:maxSumRight]);

    maxSum[0] = @(MAX([maxSumLeft[0] integerValue], [maxSumRight[0] integerValue]));
    maxSum[0] = @(MAX([maxSum[0] integerValue], node.value + left + right));
    
    return node.value + MAX(left, right);
}

/**
 题目30：给定一棵二叉搜索树，请调整节点的指针使每个节点都没有左子节点。调整之后的树看起来像一个链表，但仍然是二叉搜索树。
 */
+ (TreeNode *)increasingBST:(TreeNode *)root {
    if (root == nil) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray array];
    TreeNode *cur = root;
    TreeNode *prev = nil;
    TreeNode *first = nil;
    while (YES) {
        if (cur != nil) {
            [arr addObject:cur];
            cur = cur.left;
        } else if (arr.count < 1) {
            return first;
        } else {
            cur = [arr lastObject];
            [arr removeLastObject];
            if (prev != nil) {
                prev.right = cur;
            } else {
                first = cur;
            }
            prev = cur;
            cur.left = nil;
            cur = cur.right;
        }
    }
}


/**
 题目31：给定一棵二叉搜索树和它的一个节点p，请找出按中序遍历的顺序该节点p的下一个节点。假设二叉搜索树中节点的值都是唯一的。也就是找后继节点
 */
+ (TreeNode *)inorderSuccessor:(TreeNode *)root node:(TreeNode *)p {
    //时间复杂度O（h）,h为二叉树深度。空间复杂度O（1）
    TreeNode *cur = root;
    TreeNode *result = nil;
    while (cur != nil) {
        if (cur.value > p.value) {
            result = cur;
            cur = cur.left;
        } else {
            cur = cur.right;
        }
    }
    return result;

//时间复杂度O（n）。空间复杂度O（h）,h为二叉树深度
//    if (root == nil) {
//        return nil;
//    }
//    NSMutableArray *arr = [NSMutableArray array];
//    TreeNode *cur = root;
//    BOOL found = NO;
//    while (YES) {
//        if (cur != nil) {
//            [arr addObject:cur];
//            cur = cur.left;
//        } else if (arr.count < 1) {
//            break;
//        } else {
//            cur = [arr lastObject];
//            [arr removeLastObject];
//            if (found) {
//                break;
//            } else if (p == cur) {
//                found = YES;
//            }
//            cur = cur.right;
//        }
//    }
//    return cur;
}

/**
 题目32：给定一棵二叉搜索树，请将它的每个节点的值替换成树中大于或等于该节点值的所有节点值之和。假设二叉搜索树中节点的值唯一。
 分析：首先需要注意到这个题目与节点值的大小顺序相关，因为要找出比某节点的值大的所有节点。在二叉搜索树的常用遍历算法中，只有中序遍历是按照节点值递增的顺序遍历所有节点的。
 通常，二叉搜索树的中序遍历按照节点的值从小到大按顺序遍历，也就是当遍历到某个节点时比该节点的值小的节点都已经遍历过，因此也就知道了所有比该节点的值小的所有节点的值之和sum。可是题目要求把每个节点的值替换成大于或等于该节点的值的所有节点的值之和。因此，可以先遍历一遍二叉树求出所有节点的值之和total，再用total减去sum即可。
 上面的思路需要遍历二叉搜索树两次，第1次不管用什么算法只要遍历所有节点即可，第2次则必须采用中序遍历。是否可以只遍历二叉搜索树一次呢？
 如果能够按照节点值从大到小按顺序遍历二叉搜索树，那么只需要遍历一次就够了，因为遍历到一个节点之前值大于该节点的值的所有节点已经遍历过。通常的中序遍历是先遍历左子树，再遍历根节点，最后遍历右子树，由于左子树节点的值较小，右子树节点的值较大，因此总体上就是按照节点的值从小到大遍历的。如果要按照节点的值从大到小遍历，那么只需要改变中序遍历的顺序，先遍历右子树，再遍历根节点，最后遍历左子树，这样遍历的顺序就颠倒过来了。
 */
+ (TreeNode *)convertBST:(TreeNode *)root {
    if (root == nil) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray array];
    TreeNode *cur = root;
    NSInteger sum = 0;
    while (YES) {
        if (cur != nil) {
            [arr addObject:cur];
            cur = cur.right;
        } else if (arr.count < 1) {
            break;
        } else {
            cur = [arr lastObject];
            [arr removeLastObject];
            sum += cur.value;
            cur.value = sum;
            cur = cur.left;
        }
    }
    return root;
}


/**
 题目33：给定一棵二叉搜索树和一个值k，请判断该二叉搜索树中是否存在值之和等于k的两个节点。假设二叉搜索树中节点的值均唯一。例如，二叉搜索树中，存在值之和等于12的两个节点（节点5和节点7），但不存在值之和为22的两个节点。
       8
     /         \
    6           10
   /    \       /       \
  5      7     9       11
 利用哈希表，时间空间复杂度都为O（n）。
 利用二叉搜索树的特性，用双指针实现。时间复杂度O（n），空间复杂度O（h）
 */
+ (BOOL)findTarget:(TreeNode *)root k:(NSInteger)k {
    if (root == nil) {
        return false;
    }
    BSTIterator *bstNext = [BSTIterator bstIterator:root];
    BSTIteratorReversed *bstPrev = [BSTIteratorReversed bstIteratorReversed:root];
    NSInteger next = [bstNext next];
    NSInteger prev = [bstPrev prev];
    while (next != prev) {
        if (next + prev == k) {
            return YES;;
        }
        if (next + prev < k) {
            next = [bstNext next];
        } else {
            prev = [bstPrev prev];
        }
    }
    return NO;
}

/**
 题目34：输入一个排序的整数数组nums和一个目标值t，如果数组nums中包含t，则返回t在数组中的下标；如果数组nums中不包含t，则返回将t按顺序插入数组nums中的下标。假设数组中没有相同的数字。例如，输入数组nums为[1，3，6，8]，如果目标值t为3，则输出1；如果t为5，则返回2。
 */
+ (NSInteger)searchInsert:(NSArray *)arr target:(NSInteger)target {
    //数组为空，放第一个
    if (arr == nil) {
        return 0;
    }
    NSInteger first = 0;
    NSInteger last = arr.count - 1;
    NSInteger i = -1;
    while (first <= last) {
        i = first + (last - first) / 2;
        NSInteger v = [arr[i] integerValue];
        if (v >= target) {
            if (i == 0 || [arr[i- 1] integerValue] < target) {
                return i;
            }
            last = i - 1;
        } else {
            first = i + 1;
        }
    }
    //如果没有找到那就是放数组最后一个位置
    return arr.count;
}

/**
 题目35：在一个长度大于或等于3的数组中，任意相邻的两个数字都不相等。该数组的前若干数字是递增的，之后的数字是递减的，因此它的值看起来像一座山峰。请找出山峰顶部，即数组中最大值的位置。例如，在数组[1，3，5，4，2]中，最大值是5，输出它在数组中的下标2。
 */
+ (NSInteger)peakIndexInMountainArray:(NSArray *)arr {
    if (arr == nil) {
        return -1;
    }
    NSInteger first = 1;
    NSInteger last = arr.count - 2;
    NSInteger i = -1;
    while (first <= last) {
        i = first + (last - first) / 2;
        NSInteger v = [arr[i] integerValue];
        NSInteger prev = [arr[i - 1] integerValue];
        if (v > prev &&  v > [arr[i + 1] integerValue]) {
            return i;
        }
        if (v < prev) {
            last = i - 1;
        } else {
            first = i + 1;
        }
    }
    return -1;
}

/**
 二分查找
 */
+ (NSInteger)binarySearch:(NSArray *)arr target:(NSInteger)target {
    if (arr == nil) {
        return -1;
    }
    NSInteger first = 0;
    NSInteger last = arr.count - 1;
    NSInteger i = -1;
    while (first <= last) {
        i = first + (last - first) / 2;
        NSInteger v = [arr[i] integerValue];
        if (target == v) {
            return i;
        } else {
            if (target > v) {
                first = i + 1;
            } else {
                last = i - 1;
            }
        }
    }
    return -1;
}

/**
 题目36：在一个排序的数组中，除一个数字只出现一次之外，其他数字都出现了两次，请找出这个唯一只出现一次的数字。例如，在数组[1，1，2，2，3，4，4，5，5]中，数字3只出现了一次。
 */
+ (NSInteger)singleNonDuplicate:(NSArray *)arr {
    if (arr == nil) {
        return -1;
    }
    NSInteger first = 0;
    NSInteger last = arr.count / 2;
    while (first <= last) {
        NSInteger mid = first + (last - first) / 2;
        NSInteger v = [arr[mid] integerValue];
        NSInteger i = mid * 2;
        if (i < arr.count - 1 && v != [arr[i + 1] integerValue]) {
            if (mid == 0 || [arr[i - 1] integerValue] == [arr[i - 2] integerValue]) {
                return v;
            }
            last = mid - 1;
        } else {
            first = mid + 1;
        }
    }
    return [[arr lastObject] integerValue];
}

/**
 题目37：输入一个正整数数组w，数组中的每个数字w[i]表示下标i的权重，请实现一个函数pickIndex根据权重比例随机选择一个下标。例如，如果权重数组w为[1，2，3，4]，那么函数pickIndex将有10%的概率选择0、20%的概率选择1、30%的概率选择2、40%的概率选择3。
 */
+ (NSInteger)pickIndex:(NSArray *)arr {
    if (arr == nil) {
        return -1;
    }
    NSMutableArray *sums = [NSMutableArray array];
    NSUInteger total = 0;
    for (int i = 0; i < arr.count; i++) {
        total += [arr[i] integerValue];
        sums[i] = @(total);
    }
    NSInteger first = 0;
    NSInteger last = sums.count;
    NSInteger p = arc4random() % total;
    while (first <= last) {
        NSInteger mid = first + (last - first) / 2;
        NSInteger v = [arr[mid] integerValue];
        if (v > p) {
            if (mid == 0 || [sums[mid - 1] integerValue] <= p) {
                return mid;
            }
            last = mid - 1;
        } else {
            first = mid + 1;
        }
    }
    return -1;
}

/**
 题目38：输入一个非负整数，请计算它的平方根。正数的平方根有两个，只输出其中的正数平方根。如果平方根不是整数，那么只需要输出它的整数部分。例如，如果输入4则输出2；如果输入18则输出4。
 */
+ (NSInteger)mySqrt:(NSInteger)n {
    NSInteger left = 1;
    NSInteger right = n;
    while (left <= right) {
        NSInteger mid = left + (right - left) / 2;
        if (mid <= n / mid) {
            if ((mid + 1) > n / (mid + 1)) {
                return mid;
            }
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return 0;
}

/**
 题目39：狒狒很喜欢吃香蕉。一天它发现了n堆香蕉，第i堆有piles[i]根香蕉。门卫刚好走开，H小时后才会回来。狒狒吃香蕉喜欢细嚼慢咽，但又想在门卫回来之前吃完所有的香蕉。请问狒狒每小时至少吃多少根香蕉？如果狒狒决定每小时吃k根香蕉，而它在吃的某一堆剩余的香蕉的数目少于k，那么它只会将这一堆的香蕉吃完，下一个小时才会开始吃另一堆的香蕉。
 例如，有4堆香蕉，表示香蕉数目的数组piles为[3，6，7，11]，门卫将于8小时之后回来，那么狒狒每小时吃香蕉的最少数目为4根。如果它每小时吃4根香蕉，那么它用8小时吃完所有香蕉。如果它每小时只吃3根香蕉，则需要10小时，不能在门卫回来之前吃完。
 */
+ (NSInteger)minEatingSpeed:(NSArray *)arr h:(NSInteger)h {
    if (arr == nil) {
        return -1;
    }
    NSInteger max = INT32_MIN;
    for (id obj in arr) {
        max = MAX(max, [obj integerValue]);
    }
    //如果总共有m堆香蕉，最大一堆香蕉的数目为n，函数minEatingSpeed在1到n的范围内做二分查找，需要尝试O（logn）次，每尝试一次需要遍历整个数组求出按某一速度吃完所有香蕉需要的时间，因此总的时间复杂度是O（mlogn）。
    NSInteger left = 1;
    NSInteger right = max;
    while (left <= right) {
        NSInteger mid = left + (right - left) / 2;
        NSInteger hours = [self getHours:arr speed:mid];
        if (hours <= h) {
            if (mid == 1 || [self getHours:arr speed:mid - 1] > h) {
                return mid;
            }
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return -1;
}

+ (NSInteger)getHours:(NSArray *)arr speed:(NSInteger)speed {
    NSInteger hours = 0;
    for (id obj in arr) {
        hours += ([obj integerValue] + speed - 1) / speed;
    }
    return hours;
}

/**
 题目41：输入一个链表的头节点，请将该链表排序。例如
 3-5-1-4-2-6
 1-2-3-4-5-6
 */
+ (LinkedNode *)sortList:(LinkedNode *)head {
    if (head == nil || head.next == nil) {
        return head;
    }
    LinkedNode *head1 = head;
    LinkedNode *head2 = [self split:head];
    head1 = [self sortList:head1];
    head2 = [self sortList:head2];
    return [self merge:head1 head2:head2];
}

+ (LinkedNode *)split:(LinkedNode *)head {
    LinkedNode *slow = head;
    LinkedNode *fast = head.next;
    while (fast != nil && fast.next != nil) {
        slow = slow.next;
        fast = fast.next.next;
    }
    LinkedNode *second = slow.next;
    slow.next = nil;
    return second;
}

+ (LinkedNode *)merge:(LinkedNode *)head1 head2:(LinkedNode *)head2 {
    LinkedNode *dummy = [LinkedNode nodeValue:0];
    LinkedNode *cur = dummy;
    while (head1 != nil && head2 != nil) {
        if (head1.value > head2.value) {
            cur.next = head2;
            head2 = head2.next;
        } else {
            cur.next = head1;
            head1 = head1.next;
        }
        cur = cur.next;
    }
    cur.next = head1 == nil ? head2 : head1;
    return dummy.next;
}

/**
 题目42：输入k个排序的链表，请将它们合并成一个排序的链表。例如，输入3个排序的链表
 1-4-7
 2-5-8
 3-6-9
 */
+ (LinkedNode *)mergeKLists:(NSArray <LinkedNode *> *)list {
    if (list.count == 0) {
        return nil;
    }
    return [self mergeLists:list start:0 end:list.count];
}

+ (LinkedNode *)mergeLists:(NSArray <LinkedNode *> *)list start:(NSInteger)start end:(NSInteger)end {
    if (start + 1 == end) {
        return list[start];
    }
    NSInteger mid = start + (end - start) / 2;
    LinkedNode *head1 = [self mergeLists:list start:start end:mid];
    LinkedNode *head2 = [self mergeLists:list start:mid end:end];
    return [self merge:head1 head2:head2];
}


@end
