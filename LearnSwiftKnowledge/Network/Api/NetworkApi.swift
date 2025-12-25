//
//  BaseNetworkApi.swift
//  HandSignedTreasure
//
//  Created by 刘帅 on 2025/12/16.
//  Copyright © 2025 XACA. All rights reserved.
//

import Foundation
import Moya
internal import Alamofire

enum NetworkApi {
    case getConfigIpAddress
}


extension NetworkApi: TargetType{
        var baseURL: URL {
            return URL(string: Base_URL)!
        }
    
        var path: String {
           return "/sysServerConfig/getAllserverConfigList.do"
        }
    
        var method: Moya.Method {
            return .post
        }
    
        var task: Moya.Task {
            // 公共参数
            let params: [String: Any] = [:]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    
        var headers: [String : String]? {
            var headers: [String: String] = [:]
            headers["Content-type"] = "application/x-www-form-urlencoded"
            return headers
        }
}
