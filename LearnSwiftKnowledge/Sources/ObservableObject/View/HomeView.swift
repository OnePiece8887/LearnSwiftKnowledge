//
//  HomeView.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2025/12/24.
//

import SwiftUI
import SwiftUIX
import SwifterSwift
import SwiftMessages
struct HomeView: View {
  
    @State private var title: String?
    
    @StateObject private var homeViewModel: HomeViewModel = HomeViewModel()
    //    用于监听子视图属性
    @ViewStorage private var parentIsShow: Bool = true
    
    @State private var textHidden: Bool = true
    
  
    var body: some View {
        VStack {
            Text(homeViewModel.title ?? "")
                .font(.largeTitle)
                .foregroundStyle(.brown)
                .visible(textHidden)
            //监听子视图属性变化
                .onReceive($parentIsShow.publisher) { result in
                    textHidden = result
                }
            Button("获取数据") {
                homeViewModel.fetchData()
            }
            
            Text(homeViewModel.getUserDefaultText() ?? "")
            //            子视图
//                SubSwiftUIView(isShow: $parentIsShow.binding).environmentObject(homeViewModel)
            
//            NavigationLink {
//                SubSwiftUIView(isShow: $parentIsShow.binding).environmentObject(homeViewModel)
//            } label: {
//                Text("跳转到子视图").foregroundStyle(.red)
//            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name.notificationHomePage)) { notification in
            LSDPrint(notification)
            
//            let error = MessageView.viewFromNib(layout: .tabView)
//            error.configureTheme(.error)
//            error.configureContent(title: "Error", body: "Something is horribly wrong!")
//            error.button?.setTitle("Stop", for: .normal)
//            SwiftMessages.show(view: error)
            
            
            let warning = MessageView.viewFromNib(layout: .cardView)
            warning.configureTheme(.warning)
            warning.configureDropShadow()
            
            let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
            warning.configureContent(title: "Warning", body: "Consider yourself warned.", iconText: iconText)
            warning.button?.isHidden = true
            var warningConfig = SwiftMessages.defaultConfig
            warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
            SwiftMessages.show(config: warningConfig, view: warning)
        }
    }
}

#Preview {
    HomeView()
}
