//
//  BigBoardChartDataModule.swift
//  Pods
//
//  Created by Dalton Hinterscher on 5/20/16.
//
//

import UIKit
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

class BigBoardChartDataModule: Mappable {
    
    private static var dateFormatter:NSDateFormatter?
    private static func sharedDateFormatter() -> NSDateFormatter {
        if dateFormatter == nil {
            dateFormatter = NSDateFormatter()
            dateFormatter?.dateFormat = "yyyy-MM-dd"
        }
        
        return dateFormatter!
    }

    var dates:[NSDate]!
    var series:[BigBoardChartDataModuleSeries]!
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        dates = []
        series <- map["series"]
        
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
