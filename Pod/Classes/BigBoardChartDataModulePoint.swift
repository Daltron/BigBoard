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

public class BigBoardChartDataModulePoint: Mappable {
    
    private static var dateFormatter:NSDateFormatter?
    private static func sharedDateFormatter() -> NSDateFormatter {
        if dateFormatter == nil {
            dateFormatter = NSDateFormatter()
            dateFormatter?.dateFormat = "yyyy-MM-dd"
        }
        
        return dateFormatter!
    }
    
    var date:NSDate!
    var close:Double!
    var high:Double!
    var low:Double!
    var open:Double!
    var volume:Int!
    
    required public init?(_ map: Map) {
        mapping(map)
    }
        
    public func mapping(map: Map) {
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
            dateAsString.insertString("-", atIndex: 4)
            dateAsString.insertString("-", atIndex: 7)
            date = BigBoardChartDataModulePoint.sharedDateFormatter().dateFromString(dateAsString as String)!
        }
    }

}
