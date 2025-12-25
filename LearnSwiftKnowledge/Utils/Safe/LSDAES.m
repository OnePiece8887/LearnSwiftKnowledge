//
//  LSDAES.m
//  yizhuang
//
//  Created by caomao on 2017/5/27.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDAES.h"
#import <CommonCrypto/CommonCryptor.h>


@implementation LSDAES
+(NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key lv:(NSString *)lv
 {
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [lv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];

    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];


    NSUInteger dataLength = [data length];

    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    unsigned long newSize = 0;

    if(diff > 0)
    {
        newSize = dataLength + diff;
    }

    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }

    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);

    size_t numBytesCrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);

    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
       
        //对加密后的二进制数据进行base64转码
        return [resultData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    free(buffer);
    return nil;
    
}

+(NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key lv:(NSString *)lv
{
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [lv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
     
    //先对加密的字符串进行base64解码
    NSData *data = [[NSData alloc] initWithBase64EncodedString:encryptText options:NSDataBase64DecodingIgnoreUnknownCharacters];
     
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}
 
+(NSString *)AES256Encrypt:(NSString *)sourceStr  aeskey:(NSString *)aeskey{
    
    if (!sourceStr){
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [aeskey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
     
    NSData *sourceData = [sourceStr dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [sourceData length];
    size_t buffersize = dataLength+kCCBlockSizeAES128;
    void *buffer = malloc(buffersize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [sourceData bytes], dataLength, buffer, buffersize, &numBytesEncrypted);
     
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        //对加密后的二进制数据进行base64转码
        return [encryptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    } else {
        free(buffer);
        return nil;
    }
    
}

+(NSString *)AES256Decrypt:(NSString *)secretStr aeskey:(NSString *)aeskey{
    
   if (!secretStr) {
        return nil;
    }
    //先对加密的字符串进行base64解码
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:secretStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
     
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [aeskey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
     
    NSUInteger dataLength = [decodeData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [decodeData bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return result;
    } else {
        free(buffer);
        return nil;
    }
}

// 普通字符串转换为十六进
+ (NSString *)hexStringFromData:(NSData *)data {
    Byte *bytes = (Byte *)[data bytes];
    // 下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i=0; i<[data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i] & 0xff]; //16进制数
        newHexStr = [newHexStr uppercaseString];
        
        if([newHexStr length] == 1) {
            newHexStr = [NSString stringWithFormat:@"0%@",newHexStr];
        }
        
        hexStr = [hexStr stringByAppendingString:newHexStr];
        
    }
    return hexStr;
}

//参考：http://blog.csdn.net/linux_zkf/article/details/17124577
//十六进制转Data
+ (NSData*)dataForHexString:(NSString*)hexString
{
    if (hexString == nil) {
        
        return nil;
    }
    
    const char* ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* data = [NSMutableData data];
    while (*ch) {
        if (*ch == ' ') {
            continue;
        }
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') {
            
            byte = *ch - '0';
        }else if ('a' <= *ch && *ch <= 'f') {
            
            byte = *ch - 'a' + 10;
        }else if ('A' <= *ch && *ch <= 'F') {
            
            byte = *ch - 'A' + 10;
            
        }
        
        ch++;
        
        byte = byte << 4;
        
        if (*ch) {
            
            if ('0' <= *ch && *ch <= '9') {
                
                byte += *ch - '0';
                
            } else if ('a' <= *ch && *ch <= 'f') {
                
                byte += *ch - 'a' + 10;
                
            }else if('A' <= *ch && *ch <= 'F'){
                
                byte += *ch - 'A' + 10;
                
            }
            
            ch++;
            
        }
        
        [data appendBytes:&byte length:1];
        
    }
    
    return data;
}

@end
