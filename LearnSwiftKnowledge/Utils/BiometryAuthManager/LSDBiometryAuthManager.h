//
//  LSDBiometryAuthManager.h
//  ManuallySignedTreasure
//
//  Created by 刘帅 on 2023/6/12.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
NS_ASSUME_NONNULL_BEGIN

@interface LSDBiometryAuthManager : NSObject


+(void)canBiometryVerifyCompletion:(void(^)(LABiometryType type, NSError * _Nullable error))completion;

+(BOOL)monitorBiometryStatusCompletion:(void(^)(NSInteger code, NSString *msg)) completion;

+(LABiometryType)biometryType;
  
//code为0 为验证成功
+(void)startBiometryVerifyCompletion:(void(^)(NSInteger code, NSString *msg))completion;

@end

NS_ASSUME_NONNULL_END
