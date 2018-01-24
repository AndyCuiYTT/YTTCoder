## [YTTCoder](https://github.com/AndyCuiYTT/YTTCoder)

![](https://img.shields.io/badge/language-swift-green.svg) [![CRAN](https://img.shields.io/cocoapods/l/SliderViews.svg)]() ![](https://img.shields.io/cocoapods/v/YTTCoder.svg) [![](https://img.shields.io/badge/blog-AndyCuiの博客-yellowgreen.svg)](http://andycui.top)

实现常用的数据解析,例如: JSON 转 Model, 字典转 JSON等
#### YTTJsonCodable: JSON 与 Model 之间相互转化的工具类
> 提供数据转化的类方法,可直接调用.

#### YTTJson: 协议,继承Codable协议
> 定义 Model 实体类只需遵守该协议即可调用装换方法.

#### YTTArrayCoder: 数组扩展类
> 调用使用 obj.ytt.toJson() 形式调用
> 
> * toJson: 数组转 JSON 字符串

#### YTTDictionaryCoder: 字典扩展类
> 调用使用 obj.ytt.toJson() 形式调用
> 
> * toJson: 字典转 JSON 字符串
> * getValue(withKeyPath): 根据路径获取值

#### YTTStringCoder: 字符串扩展类
> 调用使用 obj.ytt.toDictionary() 形式调用
> 
> * toDictionary: JSON 字符串转字典
> * toArray: JSON 字符串转数组
> * toDate: 时间字符串转 Date 对象

#### YTTDateCoder: Date 扩展类
> 调用使用 obj.ytt.toString() 形式调用
> 
> * toString: Date 格式化

