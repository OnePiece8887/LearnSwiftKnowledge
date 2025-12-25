//
//  LSDAlert.h
//  ManuallySignedTreasure
//
//  Created by 刘帅 on 2023/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LSDAlertActionCallBack)(void);

@interface LSDAlert : NSObject
 
+(void)showTitle:(nullable NSString *)title content:(nullable NSString *)content btnTitle:(NSString *)btnTitle btnAction:(nullable LSDAlertActionCallBack)btnAction;

+(void)showTitle:(nullable NSString *)title content:(nullable NSString *)content leftTitle:(nullable NSString *)leftTitle leftAction:(nullable LSDAlertActionCallBack)leftAction rightTitle:(nullable NSString *)rightTitle rightAction:(nullable LSDAlertActionCallBack)rightAction;

@end

NS_ASSUME_NONNULL_END
