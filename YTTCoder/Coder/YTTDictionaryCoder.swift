//
//  YTTDictionaryCoder.swift
//  YTTJsonCodable
//
//  Created by AndyCui on 2018/1/11.
//  Copyright © 2018年 AndyCuiYTT. All rights reserved.
//

import UIKit

public extension Dictionary {
    
    var ytt: YTTDictionaryCoder<Dictionary> {
        get {
            return YTTDictionaryCoder(self)
        }
    }
    
}



public class YTTDictionaryCoder<T> {
    
    var dictionary: T
    
    init(_ dictionary: T) {
        self.dictionary = dictionary
    }
    
    
    /// 字典转 JSON 字符串
    ///
    /// - Returns: 转化后字符串
    /// - Throws: 异常(YTTJsonCodableError)
    public func toJson() throws -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            if let jsonStr = String(data: jsonData, encoding: .utf8) {
                return jsonStr
            }else {
                throw YTTJsonCodableError.DataError
            }
            
        } catch {
            throw YTTJsonCodableError.EncodableError
        }
    }
    
    /// 根据路径获取字典 value
    ///
    /// - Parameter keyPath: 路径地址(class.student)
    /// - Returns: 目标路径下的值,若路径错误返回 nil
    public func getValue(withKeyPath keyPath: String) -> Any? {
        
        if var lastValue = dictionary as? [String: Any] {
            let keyArr = keyPath.components(separatedBy: ".")
            for i in 0 ..< keyArr.count {
                if i < keyArr.count - 1 {
                    if let value = lastValue[keyArr[i]] as? Dictionary<String, Any> {
                        lastValue = value
                    }else {
                        return nil
                    }
                }else {
                    return lastValue[keyArr[i]]
                }
            }
        }
        return nil
    }
    
    
    
    
    
}
