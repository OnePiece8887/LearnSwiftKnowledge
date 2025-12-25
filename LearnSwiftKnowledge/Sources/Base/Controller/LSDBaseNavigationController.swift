//
//  LSDBaseNavigationViewController.swift
//  HandSignedTreasure
//
//  Created by 刘帅 on 2025/12/10.
//  Copyright © 2025 XACA. All rights reserved.
//

import UIKit
import SwifterSwift

class LSDBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configNavbarStyle()
    }
    
    /// 配置Navbar样式
    func configNavbarStyle()  {
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : LSDNavTitleColor,
            NSAttributedString.Key.font : LSDNavTitleFontSize
        ]
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = titleTextAttributes
        standardAppearance.backgroundColor = LSDNavBackgroundColor
        standardAppearance.backgroundImage = UIImage.init(color: LSDNavBackgroundColor, size: self.navigationBar.frame.size) 
        standardAppearance.backgroundEffect = nil
        standardAppearance.shadowImage = UIImage.init()
        standardAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = standardAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = standardAppearance
    }
}

extension LSDBaseNavigationController{
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
         super.pushViewController(viewController, animated: true)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if viewControllers.count > 1 {
            self.topViewController?.hidesBottomBarWhenPushed = false
        }
        return super.popToRootViewController(animated: animated)
    }
     
    override var childForStatusBarStyle: UIViewController?{
        //        信号栏样式
        /*
         局部可以改变样式使用viewControllers.last
         全局样式使用topViewController
         */
        return viewControllers.last
    }
    
    //MARK:- 旋转屏幕
    override var shouldAutorotate: Bool{
        return viewControllers.last?.shouldAutorotate ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return viewControllers.last?.supportedInterfaceOrientations ?? .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return viewControllers.last?.preferredInterfaceOrientationForPresentation ?? .portrait
    }

    
}
