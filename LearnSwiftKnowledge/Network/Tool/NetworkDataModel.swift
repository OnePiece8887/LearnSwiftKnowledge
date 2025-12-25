//
//  NetworkDataModel.swift
//  SwiftProject
//
//  Created by yafei li on 2024/6/13.
//

import Foundation
// 通用响应数据模型
struct NetworkDataModel<T: Codable>: Codable {
    var code: Int?
    var data: T?
    var msg: String?
    
    init(code: Int? = nil,data: T? = nil, msg: String? = nil) {
        self.code = code
        self.data = data
        self.msg = msg
    }
}
// 通用响应数据模型
struct NetworkResponseModel: Codable {
    var code: Int?
    var msg: String?
    
    init(code: Int? = nil, msg: String? = nil) {
        self.code = code
        self.msg = msg
    }
}



 
