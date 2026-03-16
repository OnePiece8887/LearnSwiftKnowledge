//
//  BaseUIHostingController.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2025/12/26.
//

import SwiftUI
import UIKit

open class BaseUIHostingController<Content: View>: UIHostingController<Content> {
       // MARK: - 样式配置
       public var navigationBarStyle: NavigationBarStyle = .default
       
       public override func viewDidLoad() {
           super.viewDidLoad()
           applyNavigationBarStyle()
           setupBackItem()
       }
    
    
    //创建返回item
    func setupBackItem() {
        let backItem = UIBarButtonItem(image: UIImage(named: "iconSwiftMessages")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPreviousResponser))
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    //返回上一页
     @objc func backPreviousResponser() {
        self.navigationController?.popViewController(animated: true)
    }
       
       private func applyNavigationBarStyle() {
           let appearance = UINavigationBarAppearance()
           switch navigationBarStyle {
           case .default:
               appearance.configureWithDefaultBackground()
               appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
               appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
               
           case .custom(let backgroundColor, let titleColor,let titleFont):
               appearance.backgroundColor = backgroundColor
               appearance.titleTextAttributes = [.foregroundColor: titleColor,.font: titleFont]
               appearance.largeTitleTextAttributes = [.foregroundColor: titleColor,.font: titleFont]
               appearance.shadowColor = .clear // 可选：去掉底部阴影线
           case .transparent:
               appearance.configureWithTransparentBackground()
               appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
               appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
           }
           
           // 关键：同时设置三种 appearance，确保 iOS 13-16 行为一致
           navigationItem.standardAppearance = appearance
           navigationItem.scrollEdgeAppearance = appearance
           navigationItem.compactAppearance = appearance
           
           // 设置返回按钮颜色（tintColor）
           view.tintColor = navigationBarStyle.tintColor
       }
}
// MARK: - 样式定义
extension BaseUIHostingController {
    public enum NavigationBarStyle {
        case `default`
        case custom(backgroundColor: UIColor, titleColor: UIColor,titleFont:UIFont)
        case transparent
        
        var tintColor: UIColor {
            switch self {
            case .default: return .label
            case .custom(_, let titleColor,_): return titleColor
            case .transparent: return .white
            }
        }
    }
}
