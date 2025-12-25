//
//  LSDFileTool.m
//  ManuallySignedTreasure
//
//  Created by 刘帅 on 2023/6/15.
//

#import "LSDFileTool.h"

@implementation LSDFileTool

+(BOOL)saveBase64:(NSString *)base64String toFilePath:(NSString *)filePath atDirectoryPath:(NSString *)directoryPath{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:0];
    
    BOOL isDirectory;
    
    [[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (isDirectory) {
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            BOOL isDelete = [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
            if(isDelete){
                BOOL result = [data writeToFile:filePath options:0 error:NULL];
                return result;
            }else{
                return NO;
            }
        }else{
            BOOL result = [data writeToFile:filePath options:0 error:NULL];
            return result;
        }
    }else{
        BOOL  isDirectoryResult = [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:NULL error:NULL];
        if(isDirectoryResult){
            if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
                BOOL isDelete = [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
                if(isDelete){
                    BOOL result = [data writeToFile:filePath options:0 error:NULL];
                    return result;
                }else{
                    return NO;
                }
            }else{
                BOOL result = [data writeToFile:filePath options:0 error:NULL];
                return result;
            }
        }else{
            return NO;
        }
    }
     
}
 
@end
