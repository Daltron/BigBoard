//
//  BigBoardTestsHelper.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class BigBoardTestsHelper: NSObject {
    
    class func sampleDateRange() -> BigBoardHistoricalDateRange {
        return BigBoardHistoricalDateRange(startDate: sampleStartDate(), endDate: sampleEndDate())
    }

    class func sampleStartDate() -> NSDate {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        let dateComponents = NSDateComponents()
        dateComponents.year = 2015
        dateComponents.month = 6
        dateComponents.day = 4
        
        return calendar!.dateFromComponents(dateComponents)!
    }
    
    class func sampleEndDate() -> NSDate {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        let dateComponents = NSDateComponents()
        dateComponents.year = 2015
        dateComponents.month = 6
        dateComponents.day = 11
        
        return calendar!.dateFromComponents(dateComponents)!
    }

}
