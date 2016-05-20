//
//  BigBoardChartDataModuleSeries.swift
//  Pods
//
//  Created by Dalton Hinterscher on 5/20/16.
//
//

import UIKit
import ObjectMapper

class BigBoardChartDataModuleSeries: Mappable {
    
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
    
    required init?(_ map: Map) {
        mapping(map)
    }
        
    func mapping(map: Map) {
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
            date = BigBoardChartDataModuleSeries.sharedDateFormatter().dateFromString(dateAsString as String)!
        }
    }

}
