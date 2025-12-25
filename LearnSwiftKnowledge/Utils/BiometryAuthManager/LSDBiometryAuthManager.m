//
//  LSDBiometryAuthManager.m
//  ManuallySignedTreasure
//
//  Created by 刘帅 on 2023/6/12.
//

#import "LSDBiometryAuthManager.h"

@implementation LSDBiometryAuthManager
+(LABiometryType)biometryType{
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    return  context.biometryType;
}
  
+(void)canBiometryVerifyCompletion:(void(^)(LABiometryType type, NSError* _Nullable error))completion{
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(error){
            completion(context.biometryType,error);
        }else{
            completion(context.biometryType,nil);
        }
    });
}

+(void)startBiometryVerifyCompletion:(void(^)(NSInteger code, NSString *msg)) completion{
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"继续验证";
    NSError *error;
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if(error){
        switch (error.code) {
            case LAErrorBiometryNotEnrolled:
            {
                NSString *content =  @"";
               if(context.biometryType == LABiometryTypeFaceID){
                   content = @"未检测到面容ID";
               }else if (context.biometryType == LABiometryTypeTouchID){
                   content = @"未检测到指纹";
               }
                 
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(error.code,content);
                });
            }
                break;
            case LAErrorPasscodeNotSet:
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(error.code,@"未设置手机密码");
                });
            }
                break;
            case LAErrorUserFallback:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"多次验证错误授权失败,请解锁授权" reply:^(BOOL success, NSError * _Nullable error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if(success){
                                completion(2,@"授权解锁成功,请重新设置");
                            }else{
                                completion(3,@"授权解锁失败");
                            }
                        });
                    }];
                });
            }
                break;
            case LAErrorBiometryLockout:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"多次验证错误授权失败,请解锁授权" reply:^(BOOL success, NSError * _Nullable error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if(success){
                                completion(2,@"授权解锁成功,请重新设置");
                            }else{
                                completion(3,@"授权解锁失败");
                            }
                        });
                    }];
                });
            }
                break;
            case LAErrorUserCancel:
            {
                NSLog(@"用户取消");
            }
                break;
            case LAErrorSystemCancel:
            {
                NSLog(@"系统取消");
            }
                break;
            case LAErrorAppCancel:
            {
                NSLog(@"App取消");
            }
                break;
            case LAErrorInvalidContext:
            {
                NSLog(@"上下文先前已无效");
            }
                break;
            default:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(error.code,error.localizedDescription);
                });
            }
                break;
        }
    }else{
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证" reply:^(BOOL success, NSError * _Nullable error) {
            if(success){
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(0,@"验证成功");
                });
            }else{
                switch (error.code) {
                    case LAErrorBiometryNotEnrolled:
                    {
                        NSString *content =  @"";
                       if(context.biometryType == LABiometryTypeFaceID){
                           content = @"未检测到面容ID";
                       }else if (context.biometryType == LABiometryTypeTouchID){
                           content = @"未检测到指纹";
                       }
                         
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(error.code,content);
                        });
                    }
                        break;
                    case LAErrorPasscodeNotSet:
                    {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(error.code,@"未设置手机密码");
                        });
                    }
                        break;
                    case LAErrorUserFallback:
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"多次验证错误授权失败,请解锁授权" reply:^(BOOL success, NSError * _Nullable error) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    if(success){
                                        completion(2,@"授权解锁成功,请重新设置");
                                    }else{
                                        completion(3,@"授权解锁失败");
                                    }
                                });
                            }];
                        });
                    }
                        break;
                    case LAErrorBiometryLockout:
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"多次验证错误授权失败,请解锁授权" reply:^(BOOL success, NSError * _Nullable error) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    if(success){
                                        completion(2,@"授权解锁成功,请重新设置");
                                    }else{
                                        completion(3,@"授权解锁失败");
                                    }
                                });
                            }];
                        });
                    }
                        break;
                    case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消");
                    }
                        break;
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"系统取消");
                    }
                        break;
                    case LAErrorAppCancel:
                    {
                        NSLog(@"App取消");
                    }
                        break;
                    case LAErrorInvalidContext:
                    {
                        NSLog(@"上下文先前已无效");
                    }
                        break;
                    default:
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(error.code,error.localizedDescription);
                        });
                    }
                        break;
                }
            }
        }];
    }
     
}

+(BOOL)monitorBiometryStatusCompletion:(void(^)(NSInteger code, NSString *msg)) completion{
    BOOL result = NO;
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if(error){
        result = NO;
        switch (error.code) {
            case LAErrorBiometryNotEnrolled:
            {
                NSString *content =  @"";
               if(context.biometryType == LABiometryTypeFaceID){
                   content = @"未检测到面容ID";
               }else if (context.biometryType == LABiometryTypeTouchID){
                   content = @"未检测到指纹";
               }
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(error.code,content);
                });
            }
                break;
            case LAErrorPasscodeNotSet:
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(error.code,@"未设置手机密码");
                });
            }
                break;
            case LAErrorUserCancel:
            {
                NSLog(@"用户取消");
            }
                break;
            case LAErrorSystemCancel:
            {
                NSLog(@"系统取消");
            }
                break;
            case LAErrorAppCancel:
            {
                NSLog(@"App取消");
            }
                break;
            case LAErrorInvalidContext:
            {
                NSLog(@"上下文先前已无效");
            }
                break;
            default:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(error.code,error.localizedDescription);
                });
            }
                break;
        }
    }else{
        result = YES;
    }
    
    return  result;
}

@end
