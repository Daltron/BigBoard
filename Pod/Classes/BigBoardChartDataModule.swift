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

public enum BigBoardChartDataModuleRange : String {
    case OneDay = "1d"
    case FiveDay = "5d"
    case OneMonth = "1m"
    case ThreeMonth = "3m"
    case OneYear = "1y"
    case FiveYear = "5y"
    case Lifetime = "max"
}

public class BigBoardChartDataModule: Mappable {
    
    private static var dateFormatter:NSDateFormatter?
    private static func sharedDateFormatter() -> NSDateFormatter {
        if dateFormatter == nil {
            dateFormatter = NSDateFormatter()
            dateFormatter?.dateFormat = "yyyy-MM-dd"
        }
        
        return dateFormatter!
    }

    var dates:[NSDate]!
    var dataPoints:[BigBoardChartDataModulePoint]!
    
    required public init?(_ map: Map) {
        mapping(map)
    }
    
    public func mapping(map: Map) {
        dates = []
        dataPoints <- map["series"]
        
        var labels = []
        labels <- map["labels"]
        
        let firstLabelInt = labels.firstObject! as! Int
        let firstLabelString = "\(firstLabelInt)"

        if firstLabelString.characters.count > 8 {
            dates <- (map["labels"], DateTransform())
        } else {
            for label in labels {
                let dateAsString = NSMutableString(string: "\(label)")
                dateAsString.insertString("-", atIndex: 4)
                dateAsString.insertString("-", atIndex: 7)
                dates.append(BigBoardChartDataModule.sharedDateFormatter().dateFromString(dateAsString as String)!)
            }
        }
    }
}
