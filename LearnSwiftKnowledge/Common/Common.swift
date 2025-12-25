//
//  Common.swift
//  SwiftProject
//
//  Created by 信安CA on 2023/3/15.
//
 
import UIKit 
 
//MARK:- 全局函数
/// 获取keywindow
func KGetKMainKeyWindow() -> UIWindow?{
    let application = UIApplication.shared
    var keyWindow: UIWindow?
    for scene in application.connectedScenes{
        if scene is UIWindowScene {
            let windowScene =  (scene as! UIWindowScene)
            keyWindow = windowScene.keyWindow
        }
    }
    return keyWindow    
}
/// 获取mainscreen
func KGetKMainScreen() -> UIScreen{
    let keyWindow =  KGetKMainKeyWindow()
    guard let screen = keyWindow?.screen else { return UIScreen.main }
    return screen
}
 
// 顶部安全区高度
func KGetSafeDistanceTop() -> CGFloat {
    let application = UIApplication.shared
    for scene in application.connectedScenes{
        if scene is UIWindowScene {
            let windowScene =  (scene as! UIWindowScene)
            return  windowScene.keyWindow?.safeAreaInsets.top ?? 0.0
        }
    }
    return 0.0
}
// 底部安全区高度
func KGetSafeDistanceBottom() -> CGFloat {
    let application = UIApplication.shared
    for scene in application.connectedScenes{
        if scene is UIWindowScene {
            let windowScene =  (scene as! UIWindowScene)
            return  windowScene.keyWindow?.safeAreaInsets.bottom ?? 0.0
        }
    }
    return 0.0
}

//顶部状态栏高度（包括安全区）
func KGetStatusBarHeight() -> CGFloat {
    let application = UIApplication.shared
    for scene in application.connectedScenes{
        if scene is UIWindowScene {
            let windowScene =  (scene as! UIWindowScene)
            return windowScene.statusBarManager?.statusBarFrame.size.height ?? 0.0
        }
    }
    return 0.0
}
 
// 状态栏+导航栏的高度
func KGetNavigationFullHeight() -> CGFloat {
    return KGetStatusBarHeight() + 44.0
}

// 底部导航栏高度（包括安全区）
func KGetTabBarFullHeight() -> CGFloat {
    return KGetSafeDistanceBottom() + 49.0
}
 
//MARK:- 自定义打印方法
func LSDPrint<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
    
    let fileName = (file as NSString).lastPathComponent
    
    print("\(fileName):(\(lineNum))-\(message)")
    
    #endif
}

