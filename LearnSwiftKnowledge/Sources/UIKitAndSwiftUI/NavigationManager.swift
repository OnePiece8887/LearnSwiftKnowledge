//
//  NavigationManager.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2026/3/16.
//


import UIKit
import SwiftUI

class NavigationManager {
    static let shared = NavigationManager()
    private init() {}

    // 获取当前活跃的导航控制器
    private var currentNavigationController: UINavigationController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }),
              let rootVC = window.rootViewController else {
            return nil
        }
        // 如果根是导航控制器，则返回；否则如果是其他，可能需要递归查找，这里假设根是导航控制器
        if let nav = rootVC as? UINavigationController {
            return nav
        }
        // 或者通过 presentedViewController 找到当前显示的导航控制器（这里简化）
        return rootVC.navigationController
    }

    func push<Content: View>(_ view: Content, title: String) {
        let hostingController = UIHostingController(rootView: view)
        hostingController.title = title
        // 隐藏系统返回按钮文字？可以设置 backBarButtonItem 为空字符串
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        hostingController.navigationItem.backBarButtonItem = backItem
        currentNavigationController?.pushViewController(hostingController, animated: true)
    }

    func pop() {
        currentNavigationController?.popViewController(animated: true)
    }

    func popToRoot() {
        currentNavigationController?.popToRootViewController(animated: true)
    }
}