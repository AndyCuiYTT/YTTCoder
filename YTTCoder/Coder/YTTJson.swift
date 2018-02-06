//
//  YTTJson.swift
//  YTTJsonCodable
//
//  Created by AndyCui on 2017/12/25.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit


public protocol YTTJson: Codable {
    
}

public extension YTTJson {
    public static func initWithString(jsonStr: String, keyPath: String? = nil) throws -> Self {
        
        var lastJSONStr = jsonStr
        if let path = keyPath {
            do {
                if let object = try jsonStr.ytt.toDictionary(keyType: String.self, valueType: Any.self).ytt.getValue(withKeyPath: path) {
                    if let dic = object as? [String: Any] {
                        lastJSONStr = try dic.ytt.toJson()
                    }else if let _ = object as? [Any] {
                        throw YTTJsonCodableError.DecoderError
                    }else if let str = object as? String {
                        lastJSONStr = str
                    }else {
                        lastJSONStr = ""
                    }
                }
            } catch {
                throw error
            }
        }
        
        if let jsonData = lastJSONStr.data(using: .utf8) {
            do {
                let obj = try YTTJsonCoder<Self>.jsonToObject(jsonData: jsonData)
                return obj
            } catch  {
                throw error
            }
        }else {
            throw YTTJsonCodableError.DataError
        }
    }
    
    public func toJson() throws -> String {
        do {
            let jsonData = try YTTJsonCoder<Self>.objectToJson(object: self)
            if let jsonStr = String(data: jsonData, encoding: .utf8) {
                return jsonStr
            }else{
                throw YTTJsonCodableError.DataError
            }
        } catch {
            throw error
        }
    }
}

public extension Array where Element: YTTJson {
    
   public static func initWithString(jsonStr: String, keyPath: String? = nil)throws -> Array {
        var lastJSONStr = jsonStr
        if let path = keyPath {
            do {
                if let object = try jsonStr.ytt.toDictionary(keyType: String.self, valueType: Any.self).ytt.getValue(withKeyPath: path) {
                   if let arr = object as? [Any] {
                    lastJSONStr = try arr.ytt.toJson()
                    }else {
                        throw YTTJsonCodableError.DecoderError
                    }
                }
            } catch {
                throw error
            }
        }
        if let jsonData = lastJSONStr.data(using: .utf8) {
            do {
                let obj = try JSONDecoder().decode(self, from: jsonData)
                return obj
            } catch  {
                throw error
            }
        }else {
            throw YTTJsonCodableError.DataError
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
    fileprivate class func jsonToObject(jsonData: Data) throws -> T {
        do {
            let object = try JSONDecoder().decode(T.self, from: jsonData)
            return object
        } catch {
            throw YTTJsonCodableError.DecoderError
        }
    }
    
    
    /// 将对象转换为 JSON 字符串
    ///
    /// - Parameter object: 要转换的对象
    /// - Returns: 转换后的字符串
    /// - Throws: 异常(YTTJsonCodableError)
    fileprivate class func objectToJson(object: T) throws -> Data {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(object)
            
        } catch {
            throw YTTJsonCodableError.EncodableError
        }
    }
}

