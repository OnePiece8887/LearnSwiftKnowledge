# Uncomment the next line to define a global platform for your project
 platform :ios, '15.0'

install! 'cocoapods', :warn_for_unused_master_specs_repo => false

target 'LearnSwiftKnowledge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LearnSwiftKnowledge
  pod 'RxSwift'  # 响应式框架
  pod 'RxCocoa'  # 响应式框架
  pod 'Moya'  #对Alamofire的二次封装 
  pod 'IQKeyboardManagerSwift' #键盘
  pod 'Kingfisher'  # 图片加载
  pod 'SnapKit'   # 自动布局
  pod 'TFYSwiftTabbarKit' #高度自定义的 iOS TabBar 控制器
  pod 'SwifterSwift' #工具类
  pod 'KeychainAccess'  # 钥匙串
  pod 'DNSPageView' #分页
  pod 'LEEAlert' #弹框类
  pod 'FDFullscreenPopGesture' #全屏返回手势
  pod 'DZNEmptyDataSet' #列表空白数据占位
  pod 'UITableView+FDTemplateLayoutCell' #列表高度
  pod 'FSPagerView' #Banner滚动图片
  pod 'MJRefresh'  #刷新框架
  pod 'MBProgressHUD' #hud遮罩
  pod 'SVProgressHUD' #hud遮罩
  pod 'TZImagePickerController/Basic' #相册 不含位置信息
  pod 'TOCropViewController'  #图片裁剪
  pod 'SwiftyUserDefaults' #本地存储
  pod 'SwiftMessages'# 弹窗提示  
  pod 'CryptoSwift'  # 提供加密相关的方法
  pod 'BonMot' #富文本
  pod 'UIAdapter' #优雅的iPhone等比例/全尺寸精准适配工具
  pod 'AvoidCrash' #防止闪退 
  pod 'CocoaLumberjack/Swift' #日志库
  pod 'SAMKeychain' #OC 钥匙串
  pod 'YYModel'
  pod 'LSDObjcSugar'
end


post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
               end
          end
   end
end
