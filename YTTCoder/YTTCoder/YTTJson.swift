//
//  YTTJson.swift
//  YTTJsonCodable
//
//  Created by AndyCui on 2017/12/25.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit


protocol YTTJson: Codable {
    
}

extension YTTJson {
    static func initWithString(jsonStr: String, keyPath: String? = nil) throws -> Self {
        
        var lastJSONStr = jsonStr
        if let path = keyPath {
            do {
                if let object = try jsonStr.ytt.toDictionary(keyType: String.self, valueType: Any.self).ytt.getValue(withKeyPath: path) {
                    if let dic = object as? [String: Any] {
                        lastJSONStr = try dic.ytt.toJson()
                    }else if let arr = object as? [Any] {
                        lastJSONStr = try arr.ytt.toJson()
                    }else if let str = object as? String {
                        lastJSONStr = str
                    }else {
                        lastJSONStr = ""
                    }
                }
            } catch  {
                throw error
            }
        }
        
        do {
            let obj = try YTTJsonCoder<Self>.jsonToObject(jsonStr: lastJSONStr)
            return obj
        } catch  {
            throw error
        }
    }
    
    func toJson() throws -> String {
        do {
            let jsonStr = try YTTJsonCoder<Self>.objectToJson(object: self)
            return jsonStr
        } catch {
            throw error
        }
    }
}

fileprivate class YTTJsonCoder<T: YTTJson> {
    
    /// 将 JSON 字符串转换为对象
    ///
    /// - Parameters:
    ///   - jsonStr: json 字符串
    /// - Returns: 转换后的对象
    /// - Throws: 异常(YTTJsonCodableError)
    fileprivate class func jsonToObject(jsonStr: String) throws -> T {
        if let jsonData = jsonStr.data(using: .utf8) {
            do {
                let object = try JSONDecoder().decode(T.self, from: jsonData)
                return object
            } catch {
                throw YTTJsonCodableError.DecoderError
            }
        }else {
            throw YTTJsonCodableError.DataError
        }
    }
    
    
    /// 将对象转换为 JSON 字符串
    ///
    /// - Parameter object: 要转换的对象
    /// - Returns: 转换后的字符串
    /// - Throws: 异常(YTTJsonCodableError)
    fileprivate class func objectToJson(object: T) throws -> String {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(object)
            if let jsonStr = String(data: jsonData, encoding: .utf8) {
                return jsonStr
            }else{
                throw YTTJsonCodableError.DataError
            }
        } catch {
            throw YTTJsonCodableError.EncodableError
        }
    }
}

