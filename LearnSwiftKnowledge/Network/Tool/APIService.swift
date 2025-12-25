//
//  APIService.swift
//  HandSignedTreasure
//
//  Created by 刘帅 on 2025/12/18.
//  Copyright © 2025 XACA. All rights reserved.
//

import Moya
import Foundation

/// 网络请求相关错误枚举
enum APIError: Error {
    /// HTTP 响应状态码不在成功范围（200...299）时返回，携带具体状态码
    case invalidStatusCode(Int)
    
    /// JSON 解析失败时返回，携带具体的解码错误信息
    case decodingError(DecodingError)
    
    /// 网络请求本身失败时返回，比如断网、超时等，携带底层错误
    case networkError(Error)
    
    /// 其他未知错误的兜底，携带错误信息
    case unknown(Error)
}
/// 超时时长
private var requestTimeOut: Double = 3600

// NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示
private let networkPlugin = NetworkActivityPlugin.init { changeType, target in
    switch changeType {
    case .began:
        DispatchQueue.main.async {
            HudUtil.show()
        }
    case .ended: 
        DispatchQueue.main.async {
            HudUtil.hide()
        }
    }
}

class APIService<T: TargetType> {
    //  定义了一个 MoyaProvider，负责实际发起网络请求
    private let provider: MoyaProvider<T>
    //   初始化方法
    init(networkActivityPlugin: Bool = true) {
        if networkActivityPlugin {
            provider =  MoyaProvider(endpointClosure: { (target: T) -> Endpoint in
                let endpoint: Endpoint = MoyaProvider.defaultEndpointMapping(for: target)
                //     endpoint = endpoint.adding(newHTTPHeaderFields: ["platform": "iOS", "version" : "1.0"])
                     return endpoint
            },requestClosure: {  (endpoint: Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) -> Void  in
                 do {
                     var request = try endpoint.urlRequest()
                     // 设置请求时长
                     request.timeoutInterval = requestTimeOut
                     // 打印请求参数
                     if let requestData = request.httpBody {
                         LSDPrint("请求的url：\(request.url!)" + "\n" + "\(request.httpMethod ?? "")" + "发送参数" + "\(String(data: requestData, encoding: String.Encoding.utf8) ?? "")")
                     } else {
                         LSDPrint("请求的url：\(request.url!)" + "\(String(describing: request.httpMethod))")
                     }
            
                     if let header = request.allHTTPHeaderFields {
                         LSDPrint("请求头内容\(header)")
                     }
                     done(.success(request))
                 } catch {
                     done(.failure(MoyaError.underlying(error, nil)))
                 }
                 
            },plugins: [networkPlugin],trackInflights: false)
        } else {
            provider =  MoyaProvider(endpointClosure: { (target: T) -> Endpoint in
                     let endpoint: Endpoint = MoyaProvider.defaultEndpointMapping(for: target)
                //     endpoint = endpoint.adding(newHTTPHeaderFields: ["platform": "iOS", "version" : "1.0"])
                     return endpoint
            },requestClosure: {(endpoint: Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) -> Void  in
                do {
                    var request = try endpoint.urlRequest()
                    // 设置请求时长
                    request.timeoutInterval = requestTimeOut
                    // 打印请求参数
                    if let requestData = request.httpBody {
                        LSDPrint("请求的url：\(request.url!)" + "\n" + "\(request.httpMethod ?? "")" + "发送参数" + "\(String(data: requestData, encoding: String.Encoding.utf8) ?? "")")
                    } else {
                        LSDPrint("请求的url：\(request.url!)" + "\(String(describing: request.httpMethod))")
                    }
           
                    if let header = request.allHTTPHeaderFields {
                        LSDPrint("请求头内容\(header)")
                    }
                    done(.success(request))
                } catch {
                    done(.failure(MoyaError.underlying(error, nil)))
                }
            },plugins: [],trackInflights: false)
        }
    }
     
    //  发送请求的异步方法，支持 await 调用，返回泛型 D，要求遵守 Decodable
    func request<D: Decodable>(_ target: T, type: D.Type, isShowToast: Bool = true) async throws -> D {
        // 使用 Swift 的 async/await 的桥接，将回调包装成异步函数
        try await withCheckedThrowingContinuation { continuation in
            // 调用 MoyaProvider 发起请求，传入 target（API 路径、参数等）
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    LSDPrint(response.statusCode)
                    // 判断 HTTP 状态码是否是 2xx，非 2xx 就抛错
                    guard (200...299).contains(response.statusCode) else {
                        if isShowToast {
                            HudUtil.showToastMessage(message: "网络请求失败")
                        }
                        continuation.resume(throwing: APIError.invalidStatusCode(response.statusCode))
                        return
                    }
                    do {
                        // 用 JSONDecoder 把服务器返回的 Data 解码成模型 D 
                        let json =  try  JSONDecoder().decode(NetworkResponseModel.self, from: response.data)
                        if let code = json.code, code == 0 {
                            let decoded = try JSONDecoder().decode(D.self, from: response.data)
                            // 成功就通过 continuation 把结果返回给调用者
                            continuation.resume(returning: decoded)
                        }else{
                            if isShowToast {
                                HudUtil.showToastMessage(message: json.msg ?? "")
                            }
                        }
                    } catch let decodingError as DecodingError {
                        //  解码出错，包装成 decodingError 抛出
                        if isShowToast {
                            HudUtil.showToastMessage(message: "返回数据解析错误")
                        }
                        continuation.resume(throwing: APIError.decodingError(decodingError))
                    } catch {
                        //  其他错误用 unknown 包装抛出
                        if isShowToast {
                            HudUtil.showToastMessage(message: "返回数据解析未知错误")
                        }
                        continuation.resume(throwing: APIError.unknown(error))
                    }
                case .failure(let error):
                    // 请求失败，网络错误包装抛出
                    if isShowToast {
                        HudUtil.showToastMessage(message: "网络请求失败")
                    }
                    continuation.resume(throwing: APIError.networkError(error))
                }
            }
        }
    }
}
