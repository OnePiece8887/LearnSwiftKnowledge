//
//  SubSwiftUIView.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2025/12/24.
//

import SwiftUI 
struct SubSwiftUIView: View {
    // @EnvironmentObject 从父视图中共享数据
    @EnvironmentObject var viewModel: HomeViewModel
    // @Binding 用于子视图绑定父视图数据
    @Binding var isShow: Bool
    
    @State private var text: String = ""
    @State private var originalAppearance: UINavigationBarAppearance?
    var body: some View {
        VStack {
            Text("我是子视图")
            
            Button("子视图按钮") {
                isShow.toggle()
            }
            
            Button("子视图传值") {
                LSDPrint("子视图传值")
                viewModel.updateTitle(title: "子视图传值 😁")
            }
            NavigationLink {
                SubSonView()
            } label: {
                Text("跳转到孙子视图").foregroundStyle(.red)
            }
        }
        .onAppear {
            // 保存原始样式
            originalAppearance = UINavigationBar.appearance().standardAppearance
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
        }
        .onDisappear {
            // 恢复原始样式
            if let original = originalAppearance {
                UINavigationBar.appearance().standardAppearance = original
                UINavigationBar.appearance().scrollEdgeAppearance = original
                UINavigationBar.appearance().compactAppearance = original
            }
        }
    }
}

#Preview {
    SubSwiftUIView(isShow: .constant(false)).environmentObject(HomeViewModel())
}
