//
//  CombineView.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2026/1/20.
//

import SwiftUI

struct CombineView: View {
    
    //    block 回调
    var goBack: () -> Void
    
    @State private var text = ""
       let limit = 140
    
    var body: some View {
        VStack(content: {
            List {
                       Section(header: Text("个人信息"), footer: Text("请确保信息准确")) {
                           TextField("姓名", text: .constant("张三"))
                           TextField("邮箱", text: .constant("zhangsan@example.com哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"))
                           TextEditor(text:  $text)
                               .onChange(of: text) { text in
                                   print("当前内容：", text)
                                  
                               }
                           // 简单预览：把关键词染红
                           let attributed = highlightKimi(in: text)
                           Text(AttributedString(attributed))
                               .frame(maxWidth: .infinity, alignment: .leading)
                               .padding(8)
                               .background(Color.gray.opacity(0.1))
                       }
                       
                       Section(header: Text("偏好设置")) {
                           Toggle("启用通知", isOn: .constant(true))
                           Slider(value: .constant(5.0), in: 1...10)
                       }
                   }
                   .navigationTitle("设置")
        })
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.topBarLeading) {
                    Button {
                        goBack()
                    } label: {
                        Image(systemName: "chevron.left").foregroundStyle(.white)
                    }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.topBarTrailing) {
                    Text("右一")
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.topBarTrailing) {
                    Text("右二")
                }
            }
    }
    func highlightKimi(in string: String) -> NSAttributedString {
          let attr = NSMutableAttributedString(string: string)
          let range = (string as NSString).range(of: "Kimi", options: .caseInsensitive)
          if range.location != NSNotFound {
              attr.addAttribute(.foregroundColor, value: UIColor.red, range: range)
          }
          return attr
      }
    
}

#Preview {
    CombineView(goBack: {
        
    })
}
