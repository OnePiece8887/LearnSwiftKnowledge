//
//  FirstSwiftUIView.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2026/3/16.
//


import SwiftUI

struct FirstSwiftUIView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("First SwiftUI View")
                .font(.largeTitle)
            Button("Go to Second SwiftUI") {
                NavigationManager.shared.push(SecondSwiftUIView(), title: "Second SwiftUI")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.2))
    }
}