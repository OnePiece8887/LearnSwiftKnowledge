//
//  SubSonView.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2025/12/25.
//

import SwiftUI
import SwifterSwift

struct SubSonView: View {
    
    @AppStorage("name", store: UserDefaults.standard) private var name: String?
    
    var body: some View {
        Text("我是SubSonView视图")
        Button {
            name = "修改偏好设置值为SubSonView"
        } label: {
             Text("点击SubSonView视图按钮")
        }
    }
}

#Preview {
    SubSonView()
}
