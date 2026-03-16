//
//  SecondSwiftUIView.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2026/3/16.
//


import SwiftUI

struct SecondSwiftUIView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Second SwiftUI View")
                .font(.largeTitle)
            Button("Back to UIKit Home") {
                NavigationManager.shared.popToRoot()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.1))
        // 1. 隐藏系统返回按钮
                .navigationBarBackButtonHidden(true)
                // 2. 添加自定义返回按钮
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            NavigationManager.shared.pop() // 返回上一页
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("返回")
                            }
                            .foregroundColor(.blue) // 颜色会自动跟随 tintColor，也可指定
                        }
                    }
                }
    }
}
