//
//  CombineView.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2026/1/20.
//

import SwiftUI
import Combine

struct CombineView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isExpanded = false
    
    //    block 回调
    var goBack: () -> Void
    
    @State private var text = ""
       let limit = 140
    
    @State private var cancellables = Set<AnyCancellable>()
    
    
    @StateObject private var viewModel = CombineViewModel()
   
     
    var body: some View {
        VStack(content: {
            List {
               Section(content: {
                   Button {
                       testMap()
                   } label: {
                       Text("map")
                   }
                   Button {
                       testFlatMap()
                   } label: {
                       Text("flatMap + Zip")
                   }
                   Button {
                       testCombineLatest()
                   } label: {
                       Text("CombineLatest")
                   }
                }, header: {
                    HStack {
                        Text("转换类（Transforming）")
                        Spacer()
                        Image(systemName: "chevron.right")
                        .foregroundStyle(.red)
                    }.onTapGesture {
                        isExpanded.toggle()
                    }
                }, footer: {
                
                })
               .foregroundStyle(.black)
                
                Section(content: {
                    Text("full1:\(viewModel.full1)")
                    Text("full2:\(viewModel.full2)")
                 }, header: {
                     HStack {
                         Text("结果")
                     }
                 }, footer: {
                 
                 })
            }
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
 
    func testMap() {
        [1,2,3].publisher.map{ $0 * 2 }.sink {print($0)}.store(in: &cancellables)
    }
    
    func testFlatMap() {
        fetchOne().flatMap { a in
            Publishers.Zip(
                        fetchTwo(),
                        fetchThree()
            ).map { (b, c) in
              return (b + c  , b * c)
            }
        }.sink { cc in
            print("完成:", cc)
        } receiveValue: { (result1, result2) in
            print("result1:", result1, "result2:", result2)
        }.store(in: &cancellables)
    }
    
    func fetchOne() -> AnyPublisher<Int, Error> {
        print("fetchOne")
        return Just(1).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func fetchTwo() -> AnyPublisher<Int, Error> {
        print("fetchTwo")
        return Just(2).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func fetchThree() -> AnyPublisher<Int, Error> {
        print("fetchThree")
        return Just(3).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func testCombineLatest()  {
        viewModel.changeValue1(value: 1)
        viewModel.changeValue2(value: 2)
        
        print("viewModel.full1:",viewModel.full1)
        print("viewModel.full2:",viewModel.full2)
    }
}

#Preview {
    CombineView(goBack: {
        
    })
}
