//
//  LSDHomePageVC.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2026/1/22.
//

import UIKit
import SnapKit
import SwifterSwift
import LSDObjcSugar
 

class LSDHomePageVC: LSDBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func setupUI() {
       let btn = UIButton.lsd_button(withAttributedText: "跳转到SwiftUI页面", fontSize: 18, textColor: LSDNavBackgroundColor)!
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(jumpToSwiftUIPage), for: .touchUpInside)
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin).offset(30)
        }
    }
    
    @objc func jumpToSwiftUIPage()  {
        let vc = BaseUIHostingController(rootView: FirstSwiftUIPage(callback: {[weak self] in
            let vc2 =  BaseUIHostingController(rootView: SecondSwiftUIView())
            vc2.navigationBarStyle = .custom(backgroundColor: LSDNavBackgroundColor, titleColor: LSDNavTitleColor, titleFont: LSDNavTitleFontSize)
            self?.navigationController?.pushViewController(vc2, animated: true)
        }))
        vc.navigationBarStyle = .custom(backgroundColor: LSDNavBackgroundColor, titleColor: LSDNavTitleColor, titleFont: LSDNavTitleFontSize)
       self.navigationController?.pushViewController(vc, animated: true)
    }
}
