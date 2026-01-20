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
    
    var body: some View {
        Text("Combine View")
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
    
    
}

#Preview {
    CombineView(goBack: {
        
    })
}
