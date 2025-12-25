//
//  LSDRootViewController.swift
//  HandSignedTreasure
//
//  Created by 刘帅 on 2025/12/10.
//

import UIKit
import FDFullscreenPopGesture 

class LSDBaseViewController: UIViewController {

    public var navigationBarHidden: Bool = false
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LSDRootVCBackGroundColor  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(self.navigationBarHidden == true){
            self.fd_prefersNavigationBarHidden = true
        }else{
            self.fd_prefersNavigationBarHidden = false
        }
        
        self.navigationController?.setNavigationBarHidden(self.navigationBarHidden, animated: false)
    }
     
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        
    }
     
}

extension LSDBaseViewController{
    //    信号栏样式
        override var preferredStatusBarStyle: UIStatusBarStyle{
            return .lightContent
        }
        
        override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
            let appdelegate = UIApplication.shared.delegate as? AppDelegate
            if (appdelegate?.isForceLandscape == true){
                return .landscapeRight
            }else{
                return .portrait
            }
        }
        
        
        override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
            let appdelegate = UIApplication.shared.delegate as? AppDelegate
            if (appdelegate?.isForceLandscape == true){
                return .landscapeRight
            }else{
                return .portrait
            }
        }
        
        //强制横屏
        func forceOrientationLandscape() {
            let appdelegate = UIApplication.shared.delegate as? AppDelegate
            appdelegate?.isForceLandscape = true
            appdelegate?.isForcePortrait = false
            if #available(iOS 16.0, *){
                self.setNeedsUpdateOfSupportedInterfaceOrientations()
                self.navigationController?.setNeedsUpdateOfSupportedInterfaceOrientations()
            
                for scene in UIApplication.shared.connectedScenes{
                    if scene is UIWindowScene {
                        let windowScene =  (scene as! UIWindowScene)
                        let geometryPreferences = UIWindowScene.GeometryPreferences.iOS.init(interfaceOrientations: UIInterfaceOrientationMask.landscapeRight)
                        windowScene.requestGeometryUpdate(geometryPreferences) { error in
                            LSDPrint("requestGeometryUpdateWithPreferences:\(error)")
                        }
                    }
                }
            }else{
                //强制翻转屏幕
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight, forKey: "orientation")
                //刷新
                UIViewController.attemptRotationToDeviceOrientation()
            }
        }
        //强制竖屏
        func forceOrientationPortrait() {
            let appdelegate = UIApplication.shared.delegate as? AppDelegate
            appdelegate?.isForceLandscape = false
            appdelegate?.isForcePortrait = true
            if #available(iOS 16.0, *){
                self.setNeedsUpdateOfSupportedInterfaceOrientations()
                self.navigationController?.setNeedsUpdateOfSupportedInterfaceOrientations()
            
                for scene in UIApplication.shared.connectedScenes{
                    if scene is UIWindowScene {
                        let windowScene =  (scene as! UIWindowScene)
                        let geometryPreferences = UIWindowScene.GeometryPreferences.iOS.init(interfaceOrientations: UIInterfaceOrientationMask.portrait)
                        windowScene.requestGeometryUpdate(geometryPreferences) { error in
                            LSDPrint("requestGeometryUpdateWithPreferences:\(error)")
                        }
                    }
                }
            }else{
                //强制翻转屏幕
                UIDevice.current.setValue(UIInterfaceOrientation.portrait, forKey: "orientation")
                //刷新
                UIViewController.attemptRotationToDeviceOrientation()
            }
        }
}



extension LSDBaseViewController{
  
    //返回上一页
    @objc func backPreviousResponser() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //创建返回item
    func setupBackItem() {
        let backItem = UIBarButtonItem(image: UIImage(named: "icon_zuo_jiantou")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPreviousResponser))
        self.navigationItem.leftBarButtonItem = backItem
    }
}
