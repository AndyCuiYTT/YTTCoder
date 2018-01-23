//
//  YTTArrayCoder.swift
//  YTTJsonCodable
//
//  Created by AndyCui on 2018/1/11.
//  Copyright © 2018年 AndyCuiYTT. All rights reserved.
//

import UIKit

public extension Array {
    
    var ytt: YTTArrayCoder<Array> {
        get {
            return YTTArrayCoder(self)
        }
    }
    
}



public class YTTArrayCoder<T> {
    
    var array: T
    init(_ array: T) {
        self.array = array
    }
    
    
    /// 数组转 JSON 字符串
    ///
    /// - Returns: 转换后字符串
    /// - Throws: 异常(YTTJsonCodableError)
    func toJson() throws -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
            if let jsonStr = String(data: jsonData, encoding: .utf8) {
                return jsonStr
            }else {
                throw YTTJsonCodableError.DataError
            }
        } catch {
            throw YTTJsonCodableError.EncodableError
        }
    }
    
    
}

