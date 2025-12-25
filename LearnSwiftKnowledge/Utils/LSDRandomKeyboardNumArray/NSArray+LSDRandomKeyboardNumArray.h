//
//  NSArray+LSDRandomKeyboardNumArray.h
//  ManuallySignedTreasure
//
//  Created by 刘帅 on 2024/7/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (LSDRandomKeyboardNumArray)

//产生任意范围内任意数量的随机数(使用此方法)
+(NSArray*)randomDataFromLower:(NSInteger)lower
                      toHigher:(NSInteger)higher
                  withQuantity:(NSInteger)quantity;

@end

NS_ASSUME_NONNULL_END
