//
//  NSString+Emoji.m
//  _idx_AppUniversal_library_8FA15F4C_ios_min10.0
//
//  Created by Hacks Wang on 2021/9/29.
//

#import "NSString+Emoji.h"
//官方的公开数据文档 https://unicode.org/Public/emoji/
@implementation NSString (Emoji)

/*
 支持版本为 Unicode 14.0 及以下，即 iOS15.0 及以下
 Unicode 和 Emoji 版本更新后需要及时更新码点枚举值
 */

- (BOOL)containsEmoji {
    __block BOOL containsEmoji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop)
     {
        if ([substring isEmoji]) {
            containsEmoji = YES;
            *stop = YES;
        }
    }];
    return containsEmoji;
}

- (BOOL)isEmoji {
    // Make sure the string is not empty
    if (self.length <= 0) {
        return NO;
    }
    // Make sure the string is a single string
    __block BOOL isSingalString = YES;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop)
     {
        if (substringRange.location > 0) {
            isSingalString = NO;
            *stop = YES;
        }
    }];
    if (!isSingalString) {
        return NO;
    }
    
    const unichar hs = [self characterAtIndex:0];
    // surrogate pair
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const unsigned long long codepoint = (((unsigned long long)hs - 0xd800) * 0x400) + ((unsigned long long)ls - 0xdc00) + 0x10000;
            if (0x1d000 <= codepoint && codepoint <= 0x1faf8) {
//                unsigned long long sym = EMOJI_CODE_TO_SYMBOL(codepoint);
//                NSString *emoji = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
//                NSLog(@"CodePoint: %llu, Emoji: %@", codepoint, emoji);
                return YES;
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        return ls == 0x20e3 || ls == 0xfe0f || ls == 0xd83c;
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x278a) {
            return YES;
        } else if (0x2793 <= hs && hs <= 0x27ff) {
            return YES;
        } else if (0x2b05 <= hs && hs <= 0x2b07) {
            return YES;
        } else if (0x2b1b <= hs && hs <= 0x2b1c) {
            return YES;
        } else if (0x2b50 == hs) {
            return YES;
        } else if (0x2b55 == hs) {
            return YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            return YES;
        } else if (0x3030 == hs) {
            return YES;
        } else if (0x303d == hs) {
            return YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            return YES;
        } else if (hs == 0xae) {
            return YES;
        } else if (hs == 0xae) {
            return YES;
        } else {
            return NO;
        }
    }
}

+ (BOOL)isEmoji:(NSString *)input {
    return [input isEmoji];
}


+ (void)outputCodePoint {
    for (int i=0x1d000; i<=0x1faf8; i++) {
        int sym = EMOJI_CODE_TO_SYMBOL(i);
        NSString *emoji = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
        NSLog(@"CodePoint: %x, Emoji: %@", i, emoji);
    }
}



/*
 Nsstring 转换为码点
 */
- (int)stringToCodePoint:(NSString *)string {
    const unichar hs = [string characterAtIndex:0];
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (string.length > 1) {
            const unichar ls = [string characterAtIndex:1];
            const int codepoint = (((int)hs - 0xd800) * 0x400) + ((int)ls - 0xdc00) + 0x10000;
            return codepoint;
        } else {
            return 0;
        }
    } else {
        return (int)hs;
    }
}

/*
 码点转换为 NSString
 */
- (NSString *)stringFromCodePoint:(int)codePoint {
    if (codePoint <= 0xFFFF)
    {
        return [[NSString alloc] initWithBytes:&codePoint length:sizeof(codePoint) encoding:NSUTF8StringEncoding];
    }
    else if (0x10000 <= codePoint && codePoint <= 0x10FFFF)
    {
        int symbol = ((((0x808080F0 | (codePoint & 0x3F000) >> 4) | (codePoint & 0xFC0) << 10) | (codePoint & 0x1C0000) << 18) | (codePoint & 0x3F) << 24);
        return [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    }
    else
    {
        return nil;
    }
}


@end
