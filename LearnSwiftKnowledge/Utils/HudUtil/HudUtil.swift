//
//  HudUtil.swift
//  SwiftProject
//
//  Created by yafei li on 2024/6/17.
//

import UIKit
import MBProgressHUD 

class HudUtil {
    //    单例
    static var hud = MBProgressHUD.showAdded(to: KGetKMainKeyWindow()!, animated: true)
    private init(){}
    
    class func show(){
        hud.show(animated: true)
    }
    
    class func hide(){
        hud.hide(animated: true)
    }
    
    
    static func showToastMessage(message: String, offset: CGPoint = .zero) {
        let keyWindow =  KGetKMainKeyWindow()
        let hud = MBProgressHUD.showAdded(to: keyWindow!, animated: true)
        hud.mode = .text
        hud.label.text = message
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
}
