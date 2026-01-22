//
//  FirstSwiftUIPage.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2026/1/22.
//

import SwiftUI

struct FirstSwiftUIPage: View {
    
    var callback: ()->Void
    
    var body: some View {
        Text("jumpToSecondSwiftUIPage").onTapGesture {
            callback()
        }
    }
}

#Preview {
    FirstSwiftUIPage(callback: {
        
    })
}
