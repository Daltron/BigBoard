/*
 
 The MIT License (MIT)
 Copyright (c) 2016 Dalton Hinterscher
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

import ObjectMapper

open class BigBoardChartDataModulePoint: Mappable {
    
    fileprivate static var dateFormatter:DateFormatter?
    fileprivate static func sharedDateFormatter() -> DateFormatter {
        if dateFormatter == nil {
            dateFormatter = DateFormatter()
            dateFormatter?.dateFormat = "yyyy-MM-dd"
        }
        
        return dateFormatter!
    }
    
    open var date:Date!
    open var close:Double!
    open var high:Double!
    open var low:Double!
    open var open:Double!
    open var volume:Int!
    
    required public init?(map: Map) {
        mapping(map: map)
    }
        
    open func mapping(map: Map) {
        date <- (map["Timestamp"], DateTransform())
        close <- map["close"]
        high <- map["high"]
        low <- map["low"]
        open <- map["open"]
        volume <- map["volume"]
        
        if date == nil {
            var dateAsInteger = 0
            dateAsInteger <- map["Date"]
            let dateAsString = NSMutableString(string: "\(dateAsInteger)")
            dateAsString.insert("-", at: 4)
            dateAsString.insert("-", at: 7)
            date = BigBoardChartDataModulePoint.sharedDateFormatter().date(from: dateAsString as String)!
        }
    }

}
