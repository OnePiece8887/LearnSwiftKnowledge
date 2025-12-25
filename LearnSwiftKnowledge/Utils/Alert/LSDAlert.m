//
//  LSDAlert.m
//  ManuallySignedTreasure
//
//  Created by 刘帅 on 2023/6/13.
//

#import "LSDAlert.h"
#import <UIKit/UIKit.h>
#import <LEEAlert/LEEAlert.h>
#import <LSDObjcSugar/LSDObjcSugar.h>
@implementation LSDAlert
 
+(void)showTitle:(nullable NSString *)title content:(nullable NSString *)content btnTitle:(NSString *)btnTitle btnAction:(nullable LSDAlertActionCallBack)btnAction{
    if (title == nil) {
        title = @"提示";
    }
    if (content == nil) {
        content = @"";
    }
    [LEEAlert alert].config
                .LeeTitle(title)
                .LeeContent(content)
                .LeeAddAction(^(LEEAction * _Nonnull action) {
                    action.type = LEEActionTypeDefault;
                    action.titleColor = [UIColor lsd_ColorWithString:@"4987EE"];
                    action.title = btnTitle;
                    action.font = [UIFont systemFontOfSize:16];
                    action.clickBlock = btnAction;
                })
                .LeeShow();
     
}


+(void)showTitle:(nullable NSString *)title content:(nullable NSString *)content leftTitle:(nullable NSString *)leftTitle leftAction:(LSDAlertActionCallBack)leftAction rightTitle:(nullable NSString *)rightTitle rightAction:(LSDAlertActionCallBack)rightAction {
    if (title == nil) {
        title = @"提示";
    }
    if (content == nil) {
        content = @"";
    }
    if(leftTitle == nil){
        leftTitle = @"取消";
    }
    if(rightTitle == nil){
        rightTitle = @"确定";
    }
    
    [LEEAlert alert].config
                .LeeTitle(title)
                .LeeContent(content)
                .LeeAddAction(^(LEEAction * _Nonnull action) {
                    action.type = LEEActionTypeDefault;
                    action.titleColor = [UIColor lsd_ColorWithString:@"666666"];
                    action.title = leftTitle;
                    action.font = [UIFont systemFontOfSize:16];
                    action.clickBlock = leftAction;
                })
                .LeeAddAction(^(LEEAction * _Nonnull action) {
                    action.type = LEEActionTypeDefault;
                    action.titleColor = [UIColor lsd_ColorWithString:@"4987EE"];
                    action.title = rightTitle;
                    action.font = [UIFont systemFontOfSize:16];
                    action.clickBlock = rightAction;
                })
                .LeeShow();
     
}


@end
