//
//  LSDFileTool.h
//  ManuallySignedTreasure
//
//  Created by 刘帅 on 2023/6/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSDFileTool : NSObject

+(BOOL)saveBase64:(NSString *)base64String toFilePath:(NSString *)filePath atDirectoryPath:(NSString *)directoryPath;


@end

NS_ASSUME_NONNULL_END
