//
//  YTTStringCoder.swift
//  YTTJsonCodable
//
//  Created by AndyCui on 2018/1/11.
//  Copyright © 2018年 AndyCuiYTT. All rights reserved.
//
import UIKit

public extension String {
    
    var ytt: YTTStringCoder {
        get {
            return YTTStringCoder(self)
        }
    }
    
}


public class YTTStringCoder {
    
    var string: String
    init(_ string: String) {
        self.string = string
    }
    
    
    /// JSON 字符串转字典
    ///
    /// - Parameters:
    ///   - keyType: 要转化的字典 key 的数据类型
    ///   - valueType: 要转化的字典 value 的数据类型
    /// - Returns: 转化后的字典
    /// - Throws: 异常(YTTJsonCodableError)
    public func toDictionary<Key, Value>(keyType: Key.Type, valueType: Value.Type) throws -> Dictionary<Key, Value> where Key: Hashable {
        
        if let jsonData = string.data(using: .utf8) {
            do {
                if let object = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? Dictionary<Key, Value> {
                    return object
                }else {
                    throw YTTJsonCodableError.DataError
                }
            } catch {
                throw YTTJsonCodableError.DecoderError
            }
        }else {
            throw YTTJsonCodableError.DataError
        }
    }
    
    
    /// JSON 字符串转数组
    ///
    /// - Parameter elementType: 数据每项数据类型
    /// - Returns: 转化后的数组
    /// - Throws: 异常(YTTJsonCodableError)
    public func toArray<Element>(elementType: Element.Type) throws -> Array<Element> {
        
        if let jsonData = string.data(using: .utf8) {
            do {
                if let object = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? Array<Element> {
                    return object
                }else {
                    throw YTTJsonCodableError.DataError
                }
            } catch {
                throw YTTJsonCodableError.DecoderError
            }
        }else {
            throw YTTJsonCodableError.DataError
        }
    }
    
    /// 字符串转 Data
    ///
    /// - Returns: 转化后的 Data
    /// - Throws: 错误
    public func toData() throws -> Data{
        if let jsonData = string.data(using: .utf8) {
            return jsonData
        }else {
            throw YTTJsonCodableError.DataError
        }
    }
    
    
    /// 时间转 Date
    ///
    /// - Parameter formatterStr: 需要的时间格式
    /// - Returns: 时间戳
    public func toDate(_ formatterStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatterStr
        return dateFormatter.date(from: string)
    }
    
    
    
    
    
}
