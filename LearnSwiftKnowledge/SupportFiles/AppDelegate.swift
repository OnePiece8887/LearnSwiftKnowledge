//
//  AppDelegate.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2025/12/24.
//

import UIKit
import CoreData
import SVProgressHUD
import SwifterSwift
import IQKeyboardManagerSwift
internal import IQKeyboardToolbarManager
internal import IQKeyboardToolbar
internal import Alamofire
import AvoidCrash
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
     
    let networkReachabilityManager = NetworkReachabilityManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    var isForceLandscape: Bool = false
    
    var isForcePortrait: Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        配置第三方库
        configThids()
        //        网络监听
        startNetworkListen()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "LearnSwiftKnowledge")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /// 配置第三方
    func configThids() {
//        HUD
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setBackgroundLayerColor(UIColor.init(hexString: "000000", transparency: 0.4)!)
        
//        #if !DEBUG
//        //        防止闪退
//        AvoidCrash.makeAllEffective()
//        let noneSelClassStrings = ["NSNull","NSNumber","NSString","NSDictionary","NSArray"]
//        AvoidCrash.setupNoneSelClassStringsArr(noneSelClassStrings)
//        //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
//        NotificationCenter.default
//            .publisher(for: Notification.Name.init(AvoidCrashNotification))
//                   .sink { [weak self] notificaiton in
//                       self?.dealwithCrashMessage(notificaiton: notificaiton)
//                   }
//                   .store(in: &cancellables)
//        #endif

       
        
        //        Bugly
//        let config = BuglyConfig()
//        config.reportLogLevel = .warn
//        config.channel = "App Store"
//        Bugly.start(withAppId: KBUGLY_APP_ID, config: config)
        

        //        键盘管理
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardToolbarManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardToolbarManager.shared.toolbarConfiguration.doneBarButtonConfiguration = IQBarButtonItemConfiguration.init(title: "完成")

    }
    
    ///        开始监听网络状态
    func startNetworkListen()  {
        
        networkReachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                LSDPrint("不可达的网络(未连接)")
            case .unknown:
                LSDPrint("未知网络")
            case .reachable(.ethernetOrWiFi):
                LSDPrint("wifi的网络")
            case .reachable(.cellular):
                LSDPrint("手机网络")
            }
        })
    }
    
//    #if !DEBUG
//    /// 捕获闪退
//    /// - Parameter notificaiton: 获取通知信息
//    @objc func dealwithCrashMessage(notificaiton: Notification) {
//        //异常拦截并且通过bugly上报
//       let userInfo = notificaiton.userInfo
//        guard let errorReason = userInfo?["errorReason"] as? String, let errorPlace = userInfo?["errorPlace"] as? String, let defaultToDo =  userInfo?["defaultToDo"] as? String, let errorName =  userInfo?["errorName"] as? String,let callStack = userInfo?["callStackSymbols"] as? [Any] else { return }
//        let reason = "【ErrorReason】\(errorReason)========【ErrorPlace】\(errorPlace)========【DefaultToDo】\(defaultToDo)========【ErrorName】\(errorName)"
//        LSDLog("捕获的错误描述:\(reason)")
//    //        Bugly.reportException(withCategory: 3, name: "AvoidCrash拦截的异常", reason: reason, callStack: callStack,extraInfo: [:], terminateApp: false)
//    }
//    #endif

}

extension AppDelegate {
    //    横竖屏
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if (self.isForceLandscape == true){
            return .landscapeRight
        }else{
            return .portrait
        }
    }
}
