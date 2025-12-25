//
//  NSArray+LSDRandomKeyboardNumArray.m
//  ManuallySignedTreasure
//
//  Created by 刘帅 on 2024/7/1.
//

#import "NSArray+LSDRandomKeyboardNumArray.h"

@implementation NSArray (LSDRandomKeyboardNumArray)

//产生任意范围内任意数量的随机数(使用此方法)
+(NSArray*)randomDataFromLower:(NSInteger)lower
                      toHigher:(NSInteger)higher
                  withQuantity:(NSInteger)quantity{
    
    NSMutableArray *myRandomNumbers=[NSMutableArray array];
    if (!quantity||quantity>(higher-lower)+1) {
        quantity=(higher-lower)+1;
    }
    while (myRandomNumbers.count!=quantity) {
        NSInteger myNumber=arc4random_uniform((uint32_t)(higher+1-lower))+(uint32_t)lower;
        if (![myRandomNumbers containsObject: @(myNumber)]) {
            [myRandomNumbers addObject:@(myNumber)];
        }
    }
    return [myRandomNumbers copy];//可变数组变成不可变
}


@end
