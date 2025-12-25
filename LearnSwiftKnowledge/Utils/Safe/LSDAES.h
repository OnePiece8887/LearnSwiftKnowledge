//
//  LSDAES.h
//  yizhuang
//
//  Created by caomao on 2017/5/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDAES : NSObject

+(NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key lv:(NSString *)lv;
+(NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key lv:(NSString *)lv;

+(NSString *)AES256Encrypt:(NSString *)sourceStr  aeskey:(NSString *)aeskey;
+(NSString *)AES256Decrypt:(NSString *)secretStr aeskey:(NSString *)aeskey;

@end
