# Uncomment the next line to define a global platform for your project
 platform :ios, '16.0'

install! 'cocoapods', :warn_for_unused_master_specs_repo => false

target 'LearnSwiftKnowledge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LearnSwiftKnowledge
  pod 'LEEAlert' #弹框类
  pod 'FDFullscreenPopGesture' #全屏返回手势
  pod 'UITableView+FDTemplateLayoutCell' #列表高度
  pod 'FSPagerView' #Banner滚动图片 
  pod 'TZImagePickerController/Basic' #相册 不含位置信息
  pod 'AvoidCrash' #防止闪退
  pod 'SAMKeychain' #OC 钥匙串
  pod 'YYModel'
end


post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
               end
          end
   end
end
