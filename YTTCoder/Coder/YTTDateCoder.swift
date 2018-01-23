//
//  YTTDateCoder.swift
//  YTTJsonCodable
//
//  Created by AndyCui on 2018/1/22.
//  Copyright © 2018年 AndyCuiYTT. All rights reserved.
//

import UIKit

public extension Date {
    var ytt: YTTDateCoder {
        get {
            return YTTDateCoder(self)
        }
    }
}

public class YTTDateCoder {
    
    var date: Date
    init(_ date: Date) {
        self.date = date
    }
    
    
    /// Date 格式化
    ///
    /// - Parameter formatterStr: 需要的时间格式
    /// - Returns: 转化后的时间
    public func toString(_ formatterStr: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatterStr
        return dateFormatter.string(from: date)
    }
    
    
}
