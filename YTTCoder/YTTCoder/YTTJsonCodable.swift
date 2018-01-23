//
//  YTTJsonCodable.swift
//  YTTJsonCodable
//
//  Created by AndyCui on 2017/12/22.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit




class YTTJsonCodable {
    
    /// 将 JSON 字符串转换为对象
    ///
    /// - Parameters:
    ///   - type: 对象类型
    ///   - jsonStr: json 字符串
    /// - Returns: 转换后的对象
    /// - Throws: 异常(YTTJsonCodableError)
    class func jsonToObject<T: Decodable>(type: T.Type, jsonStr: String) throws -> T {
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
    class func objectToJson<T: Encodable>(object: T) throws -> String {
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



