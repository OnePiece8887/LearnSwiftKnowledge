//
//  NSString+Emoji.h
//  _idx_AppUniversal_library_8FA15F4C_ios_min10.0
//
//  Created by Hacks Wang on 2021/9/29.
//

#import <Foundation/Foundation.h>

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);
 

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Emoji)

- (BOOL)containsEmoji;

/*!
 *  \if ENGLISH
 *  \brief Determines whether the string is emoji
 *  \return Returns YES means is emoji, NO means not
 *  \else
 *  \brief 判断字符串是否为 emoji
 *  \return 返回 YES 表示命中，NO 表示非命中
 *  \endif
 */
- (BOOL)isEmoji;

+ (BOOL)isEmoji:(NSString *)input;

+ (void)outputCodePoint;

@end

NS_ASSUME_NONNULL_END
