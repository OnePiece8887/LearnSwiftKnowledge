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
    
    var body: some View {
        Text("我是子视图")
        
        Button("子视图按钮") {
            isShow.toggle()
        }
        
        Button("子视图传值") {
            LSDPrint("子视图传值")
            viewModel.updateTitle(title: "子视图传值 😁")
        }
    }
}

#Preview {
    SubSwiftUIView(isShow: .constant(false)).environmentObject(HomeViewModel())
}
