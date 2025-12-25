//
//  HomeView.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2025/12/24.
//

import SwiftUI
import SwiftUIX

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
            //            子视图
            SubSwiftUIView(isShow: $parentIsShow.binding).environmentObject(homeViewModel)
        }
    }
}

#Preview {
    HomeView()
}
