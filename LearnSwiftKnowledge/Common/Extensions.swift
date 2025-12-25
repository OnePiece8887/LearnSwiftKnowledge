//
//  Extensions.swift
//  SwiftProject
//
//  Created by 信安CA on 2023/3/17.
//

import Foundation

extension Data {
    func toModel<T:Codable>(modelType:T.Type) -> T? {
        do {
            return try JSONDecoder.init().decode(modelType, from: self)
        } catch {
            debugPrint(error.localizedDescription)
            return  nil
        }
    }
    func toDictionary() -> Dictionary<String,Any>? {
        if let dic = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) {
            if let result = dic as? Dictionary<String,Any>{
                return result
            }
        }
        return nil
    }
    func toArray() -> Array<Any>? {
        if let arr = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) {
            if let result = arr as? Array<Any>{
                return result
            }
        }
        return nil
    }
    func toString() -> String? {
        return String.init(data: self, encoding: .utf8)
    }
    
}

extension Array {
    
    func toData() -> Data? {
        if JSONSerialization.isValidJSONObject(self) {
            if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
                return data
            }
        }
        return nil
    }
}
 
extension Dictionary {
    func toData() -> Data? {
        if JSONSerialization.isValidJSONObject(self) {
            if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
                return data
            }
        }
        return nil
    }
}
 
extension String {
    func toData() -> Data? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            return nil
        }
        return self.data(using: .utf8)
    }
}
