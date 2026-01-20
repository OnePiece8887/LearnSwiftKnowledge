//
//  CombineViewModel.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2026/1/20.
//

import Foundation
import Combine

class CombineViewModel: ObservableObject {
    
    @Published var prefix1 = 0
    @Published var suffix1 = 0
    @Published var full1  = ""
    @Published var full2  = ""
    
    private var cancellables = Set<AnyCancellable>()
      
    
    init() {
        Publishers.CombineLatest($prefix1, $suffix1)
                   .map { String($0) + String($1) }
                   .assign(to: &$full1)
        
        Publishers.Zip($prefix1, $suffix1)
                   .map { String($0) + String($1) }
                   .assign(to: &$full2)
    }
    
    
    func changeValue1(value: Int)  {
        prefix1 = value
    }
    
    func changeValue2(value: Int)  {
        suffix1 = value
    }
}
