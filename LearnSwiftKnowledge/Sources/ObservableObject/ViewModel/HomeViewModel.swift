//
//  HomeViewModel.swift
//  LearnSwiftKnowledge
//
//  Created by 刘帅 on 2025/12/24.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject{
    
    private var apiservice = APIService<NetworkApi>()

    @Published private(set) var allIpConfigModels: [LSDIpConfigModel] = []
    
    @Published private(set) var title: String?
    
    @AppStorage("name", store: UserDefaults.standard) private var name: String?
      
    func fetchData()  {
        Task{
           let model =  try await  apiservice.request(NetworkApi.getConfigIpAddress, type: NetworkDataModel<[LSDIpConfigModel]>.self)
           guard let data = model.data else { return  }
           await MainActor.run {
               allIpConfigModels = data
               title = data[0].serverAddress
           }
       }
    }
    
    func updateTitle(title: String) {
        self.title = title
    }
    
    func getUserDefaultText() -> String? {
        return name
    }
    
}
